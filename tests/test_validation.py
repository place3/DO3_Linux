"""Behavior tests for text input and directory validation (no third-party packages)."""

import subprocess
import tempfile
import unittest
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def run_bash(*args):
    # A different working directory also checks that main.sh locates its helpers.
    return subprocess.run(
        ["bash", *map(str, args)], cwd=tempfile.gettempdir(),
        capture_output=True, text=True, timeout=5,
    )


class TextInputTests(unittest.TestCase):
    def test_text_is_preserved(self):
        for value in ("hello", "hello world", "Привет", "abc123", "-n", "-e", r"a\tb", ""):
            with self.subTest(value=value):
                result = run_bash(ROOT / "src/01/main.sh", value)
                self.assertEqual(result.returncode, 0, result.stderr)
                self.assertEqual(result.stdout, value + "\n")
                self.assertEqual(result.stderr, "")

    def test_numbers_are_rejected(self):
        for value in ("0", "42", "-7", "3.14", "-0.5"):
            with self.subTest(value=value):
                result = run_bash(ROOT / "src/01/main.sh", value)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, "")
                self.assertIn("must not be a number", result.stderr)

    def test_exactly_one_argument_is_required(self):
        for args in ((), ("one", "two")):
            with self.subTest(args=args):
                result = run_bash(ROOT / "src/01/main.sh", *args)
                self.assertNotEqual(result.returncode, 0)
                self.assertEqual(result.stdout, "")
                self.assertIn("exactly one parameter", result.stderr)


class DirectoryInputTests(unittest.TestCase):
    def validate(self, *args):
        return run_bash(
            "-c", 'source "$1"; shift; validate_input "$@"',
            "validate-test", ROOT / "src/05/validate.sh", *args,
        )

    def assert_rejected(self, expected_error, *args):
        result = self.validate(*args)
        self.assertNotEqual(result.returncode, 0)
        self.assertEqual(result.stdout, "")
        self.assertIn(expected_error, result.stderr)

    def test_existing_directory_with_spaces_is_accepted(self):
        with tempfile.TemporaryDirectory(prefix="directory with spaces ") as directory:
            result = self.validate(directory + "/")
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout, "")
            self.assertEqual(result.stderr, "")

    def test_trailing_slash_is_required(self):
        with tempfile.TemporaryDirectory() as directory:
            self.assert_rejected("must end with '/'", directory)

    def test_missing_directory_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            self.assert_rejected("does not exist", str(Path(directory) / "missing") + "/")

    def test_regular_file_is_rejected(self):
        with tempfile.TemporaryDirectory() as directory:
            file = Path(directory) / "file.txt"
            file.write_text("example", encoding="utf-8")
            self.assert_rejected("does not exist", str(file) + "/")

    def test_exactly_one_argument_is_required(self):
        for args in ((), ("/tmp/", "/var/")):
            with self.subTest(args=args):
                self.assert_rejected("exactly one parameter", *args)


if __name__ == "__main__":
    unittest.main()
