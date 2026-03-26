# Linux Monitoring v1.0

Linux basic bash scripting and system research.

💡 **Ushbu loyiha haqida biz bilan fikr-mulohazalaringizni baham ko’rish uchun [bu yerni bosing](https://new.oprosso.net/p/4cb31ec3f47a4596bc758ea1861fb624).** Bu anonim bo’lib, jamoamizga ta’limni yaxshilashga yordam beradi. Loyihani tugatgandan so'ng darhol so'rovnomani to'ldirishni tavsiya qilamiz.

## Contents

1. [Chapter I](#chapter-i)
2. [Chapter II](#chapter-ii) \
   2.1. [Bash](#bash) \
   2.2. [Shell](#shell)
3. [Chapter III](#chapter-iii) \
   3.1. [Qalam namunasi](#part-1-qalam-namunasi)  
   3.2. [Tizim tadqiqoti](#part-2-tizimni-organish)  
   3.3. [Tizim tadqiqoti skripti uchun chiqishning vizual dizayni](#part-3-tizimni-organish-skripti-uchun-chiqishni-virtual-dizayni)  
   3.4. [Tizimni o'rganish skripti uchun vizual chiqishni sozlash](#part-4-tizimni-organish-skripti-uchun-vizual-rasmiylashtirishni-sozlash)     
   3.5. [Fayl tizimini o’rganish](#part-5-fayl-tizimini-tadqiq-qilish)
4. [Chapter IV](#chapter-iv)

## Chapter I

![linux_monitoring_v1](misc/images/linux_monitoring_v1.png)

Yer sayyorasi, bizning kunlarimiz.

Jon, odatdagidek, tirbandlik vaqtida uyga haydamaslik uchun ishda kechgacha qoldi. Qo‘shni kabinetdan shitir-shitir ovozlar eshitilgunga qadar u ishxonada o‘zidan boshqa hech kim qolmagan, deb o‘yladi. Jon bunga ahamiyat bermadi – hamkasblaridan birontasi o’z ishlarini tugatish uchun kech qolgandir? Ammo to'satdan u o'sha idoradan nidoni eshitdi (hamkasbi u ofisda yolg'iz qolgan deb o'ylayotgan edi):

`-` Voy, men ushbu Linux kompyuterlaridan tizim ma'lumotlarini qo'lda yig'ishdan juda charchadim. Ehtimol, bu yerga joylashishdan oldin uni yaxshiroq o'rganish kerak edi.

Jon darhol bu bir necha hafta oldin ishga olingan yangi tizim ma'muri ekanligini angladi.

Sizning do'stingiz Maykning tashabbusi bilan Linux ofisdagi bir nechta mashinalarga o'rnatildi. Tizim ma'muri haqiqatan ham harakat qildi, u aynan shu vaqtda ishga joylashish uchun omadsiz edi. "Bechora," deb o'yladi Jon. "Men unga yordam berishga harakat qilishim kerak, chunki vaqtim bor!" U Maykning stoliga bordi va juda yomon ish qildi: tortmasiga qaradi. Omadingiz keldi: Jon aynan izlagan narsasini topdi - bash va shell haqidagi maqolalardan parchalar.

## Chapter II

### Bash

>Bash GNU operatsion tizimi uchun qobiq yoki buyruq tili tarjimonidir.
>
>Bu nom “Bourne-Again Shell” so'zining qisqartmasi bo'lib, unixning Bell Labs tadqiqot nashrining yettinchi nashrida paydo bo'lgan hozirgi Unix sh qobig'ining bevosita ajdodi muallifi Stiven Born sharafiga so'z o'yini.
>
>Bash asosan sh bilan mos keladi va Korn shell ksh va C shell csh dan foydali xususiyatlarni o'z ichiga oladi. U IEEE POSIX spetsifikatsiyasining (IEEE Standard 1003.1) IEEE POSIX Shell va Tools qismini izchil amalga oshirish uchun mo'ljallangan. U interaktiv foydalanish va dasturlash uchun sh ga nisbatan funktsional yaxshilanishlarni taklif etadi.
>
>GNU operatsion tizimi boshqa qobiqlarni, jumladan csh versiyasini taqdim etsa ham, Bash standart qobiq hisoblanadi. Boshqa GNU dasturlari singari, Bash ham juda ko'chma. Hozirda u Unix ning deyarli barcha versiyalarida va ba'zi boshqa operatsion tizimlarda ishlaydi — MS-DOS, OS/2 va Windows platformalari uchun mustaqil ravishda qo'llab-quvvatlanadigan portlar mavjud.

### Shell

>Asosiysi, Shell shunchaki buyruqlarni bajaradigan so'l protsessordir.
>
>Unix qobig'i ham buyruq tarjimoni, ham dasturlash tilidir. Buyruqlar tarjimoni sifatida qobiq GNU utilitlarining boy to'plamiga foydalanuvchi interfeysini taqdim etadi. Buyruqlarni o'z ichiga olgan fayllar yaratilishi va o'zlari buyruqlarga aylanishi mumkin. Ushbu yangi buyruqlar tizim buyruqlari bilan bir xil maqomga ega. Bu foydalanuvchilarga yoki guruhlarga umumiy vazifalarini avtomatlashtirish uchun maxsus muhit yaratish imkonini beradi.
>
>Chig'anoqlar interaktiv yoki interaktiv bo'lmagan rejimda ishlatilishi mumkin. Interaktiv rejimda ular klaviaturadan kiritishni qabul qiladilar. Interaktiv bo'lmagan rejimda qobiqlar fayldan o'qilgan buyruqlarni bajaradi.
>
>Qobiq GNU buyruqlarini ham sinxron, ham asinxron bajarishga imkon beradi.
>
>Buyruqning bajarilishi muhim bo'lsa-da, qobiqlarning ko'p kuchi (va murakkabligi) ularga o'rnatilgan dasturlash tillaridan kelib chiqadi. Boshqa har qanday yuqori darajadagi til kabi, qobiq o'zgaruvchilar, oqimni boshqarish konstruksiyalari, tirnoq va funktsiyalarni ta'minlaydi.
>
>Shells dasturlash tilini to'ldirish uchun emas, balki interaktiv foydalanish uchun mo'ljallangan xususiyatlarni taklif qiladi. Ushbu interaktiv funktsiyalarga ishni boshqarish, buyruq qatorini tahrirlash, buyruqlar tarixi va taxalluslar kiradi.

Maqola parchalari ostida Maykning tortmasida "materials" deb yozilgan papka bor edi. Unga qarab, Jon bash - skriptlarining imkoniyatlarini tavsiflovchi bir nechta varaqlarni topdi.

## Chapter III

- Yozilgan Bash - skriptlari src papkasida joylashgan bo'lishi kerak; 
- Har bir vazifa uchun papka quyidagi nom bilan yaratilishi kerak: **0x**, bu yerda x - vazifa raqami; 
- Barcha skriptlar parchalanishi va bir nechta fayllarga bo'linishi kerak; 
- Har bir ish uchun asosiy skript fayli **main.sh** deb nomlanishi kerak; 
- Barcha skriptlarda noto'g'ri kiritish uchun tekshiruvlar bo'lishi kerak (barcha parametrlar ko'rsatilmagan, noto'g'ri formatlangan parametrlar va boshqalar); 
- Barcha yozma skriptlar *Ubuntu Server 20.04 LTS* virtual mashinasida ishga tushirilishi kerak.

## Part 1. Qalam namunasi

Hamkasbiga yordam berishni boshlashdan oldin, Jon o'z bilimini juda kichik dasturda sinab ko'rishga qaror qildi.

**== Topshiriq ==**

Bash skriptini yozing. Skript bitta parametr bilan ishga tushiriladi. Matn parametri.
Skript parametr qiymatini ko'rsatadi.
Agar parametr raqam bo'lsa, unda kiritilgan noto'g'ri ekanligini ko'rsatadigan xabar ko'rsatilishi kerak.

## Part 2. Tizimni o’rganish 

Endi Jon dastlabki g’oyasini davom ettirishga tayyor ekanligiga ishonchi komil. U tezda tizim haqida qanday ma'lumotlar ko'rsatilishi kerakligini aniqlaydi va ishga kirishadi.

**== Topshiriq ==**

Bash - skriptini yozing. Skript quyidagi shaklda ma'lumotlarni ko'rsatishi kerak:

**HOSTNAME** = _tarmoq nomi_  
**TIMEZONE** = _vaqt mintaqasi quyidagi ko'rinishda: **America/New_York UTC -5** (vaqt mintaqasi tizimdan olinishi va joriy joylashuv uchun to'g'ri bo'lishi kerak)_  
**USER** = _skriptni ishga tushirgan joriy foydalanuvchi_  
**OS** = _operatsion tizim turi va versiyasi_  
**DATE** = _hozirgi vaqt quyidagi ko’rinishda: **12 May 2020 12:24:36**_  
**UPTIME** = _tizimning ishlash vaqti_  
**UPTIME_SEC** = _tizimning ishlash vaqti soniyalarda_  
**IP** = _har qanday tarmoq interfeysida mashinaning IP-manzili_  
**MASK** = _har qanday tarmoq interfeysining tarmoq niqobi quyidagi shaklda: **xxx.xxx.xxx.xxx**_  
**GATEWAY** = _standart shlyuz IP manzili_  
**RAM_TOTAL** = _Gb dagi umumiy operativ xotira hajmi, verguldan keyin uchta belgi aniqligi bilan, quyidagicha: **3.125 GB**_  
**RAM_USED** = _Gb dagi ishlatilgan operativ xotira hajmi, verguldan keyin uchta belgi aniqligi bilan_  
**RAM_FREE** = _Gb dagi bo'sh operativ xotira hajmi, verguldan keyin uchta belgi aniqligi bilan_  
**SPACE_ROOT** = _tizim ildiz bo‘limining hajmi Mb da, ikki belgi aniqligi bilan, quyidagi ko‘rinishda: **254.25 MB**_  
**SPACE_ROOT_USED** = _tizim ildiz bo‘limida band bo‘lgan joy hajmi Mb da, ikki belgi aniqligi bilan_  
**SPACE_ROOT_FREE** = _tizim ildiz bo‘limida bo‘sh joy hajmi Mb da, ikki belgi aniqligi bilan_  

Ma'lumotlar chiqarilgandan so'ng, foydalanuvchidan **Y/N** javobini berishi so'raladi.
Javoblar **Y** va **y** ijobiy, qolganlari esa salbiy hisoblanadi.
Agar foydalanuvchi roziligini bildirsa, joriy katalogda ekranga chiqarilgan ma'lumotlarni o'z ichiga olgan fayl yaratiladi.
Fayl nomi quyidagi ko'rinishda bo'lishi kerak: **DD_MM_YY_HH_MM_SS.status** (fayl nomidagi vaqt ma'lumotlarni saqlash paytini ko'rsatadi).

## Part 3. Tizimni o’rganish skripti uchun chiqishni virtual dizayni

Hammasi tayyor! Qanchalik zerikarli… Bu dunyoga ko’proq ranglar qo’shish kerak! 

**== Topshiriq ==**

bash-skript yozing. Asos sifatida [**Part 2**](#part-2-tizimni-organish) dan skriptni oling va undan ma’lumotlarni faylga saqlash uchun javobgar bo’lgan undan ma'lumotlarni faylga saqlash uchun mas'ul bo'lgan qismni olib tashlang. Skript 4 ta parametr bilan ishga tushiriladi. Parametrlar raqamli. 1 dan 6 gacha, masalan:
`script03.sh 1 3 4 5`

Ranglarni belgilash: (1 — white, 2 — red, 3 — green, 4 — blue, 5 – purple, 6 — black)  
**Parametr 1** – bu qiymat nomlarining foni (HOSTNAME, TIMEZONE, USER va boshqalar) \
**Parametr 2** – bu qiymat nomlarining rangi (HOSTNAME, TIMEZONE, USER va boshqalar) \
**Parametr 3** – bu qiymatlar foni (‘=’ belgisidan keyin) \
**Parametr 4** – bu qiymatardan keyin shrift rangi (‘=’ belgisidan keyin).

Xuddi shu ustunning shrifti va fon ranglari mos kelmasligi kerak.
Agar siz mos qiymatlarni kiritsangiz, muammoni tavsiflovchi xabar va skriptni qayta ishga tushirish taklifini ko'rishingiz kerak.
Xabar chiqarilgandan so'ng, dastur to'g'ri yakunlanishi kerak.

## Part 4. Tizimni o'rganish skripti uchun vizual rasmiylashtirishni sozlash

Ana endi hamma narsa chiroyli! Biroq, ranglarni har safar parametr sifatida kiritish istagi qanchalik tortadi... qulayroq biror narsa o'ylab topish kerak. 

**== Topshiriq ==**

Bash - skriptini yozing. [**Part 3**](#part-3-tizimni-organish-skripti-uchun-chiqishni-virtual-dizayni) dagi skriptni asos qilib oling. Rang belgilari o'xshash.
Skript parametrlarsiz ishga tushadi. Parametrlar skriptni ishga tushirishdan oldin konfiguratsiya faylida o'rnatiladi.
Konfiguratsiya fayli quyidagicha ko'rinishi kerak:
```
column1_background=2
column1_font_color=4
column2_background=5
column2_font_color=1
```

Agar konfiguratsiya faylida bir yoki bir nechta parametr ko'rsatilmagan bo'lsa, unda rang standart rang sxemasidan almashtirilishi kerak. (Ishlab chiquvchining ixtiyoriga ko'ra tanlov).

[**Part 3**](#part-3-tizimni-organish-skripti-uchun-chiqishni-virtual-dizayni) dagi tizim haqida ma'lumotni ko'rsatgandan so'ng, siz bitta bo'sh qatorni kiritishingiz va ranglar sxemasini quyidagicha ko'rsatishingiz kerak:
```
Column 1 background = 2 (red)
Column 1 font color = 4 (blue)
Column 2 background = 5 (purple)
Column 2 font color = 1 (white)
```

Skript standart rang sxemasi bilan ishga tushirilganda, chiqish quyidagi ko'rinishda bo'lishi kerak:
```
Column 1 background = default (black)
Column 1 font color = default (white)
Column 2 background = default (red)
Column 2 font color = default (blue)
```

## Part 5. Fayl tizimini tadqiq qilish

Endi tizim haqidagi ma'lumotlarning chiqishi tayyor, chiroyli va qulay bo'lsa, siz rejaning ikkinchi qismiga o'tishingiz mumkin.

**== Topshiriq ==**

Bash - skriptini yozing. Skript bitta parametr bilan ishga tushiriladi.
Parametr - bu biron bir direktoriyaga mutlaq yoki nisbiy yo’l. Parametr '/' bilan tugashi kerak, masalan:
`script05.sh /var/log/`

Skript parametrda ko'rsatilgan katalog haqida quyidagi ma'lumotlarni chiqarishi kerak:
- Papkalarning umumiy soni, shu jumladan qo’shilgan papkalar;
- Kamayish tartibida eng katta vaznga ega bo'lgan Top - 5 ta papka (yo’l va o’lcham);
- Fayllarning umumiy soni;
- Konfiguratsiya fayllari soni (.conf kengaytmali), matnli fayllar, bajariladigan fayllar, loglar (.log kengaytmali fayllar), arxivlar, ramziy havolalar;
- Kamayish tartibida eng katta vaznga ega TOP - 10 ta fayl (yo'l, o'lcham va tur);
- Kamayish tartibida eng katta vaznga ega TOP- 10 ta bajariladigan fayllar (yo'l, o'lcham va xesh);
- Skriptni bajarish vaqti.

Skript quyidagi shaklda ma'lumotlarni ko'rsatishi kerak:

```
Total number of folders (including all nested ones) = 6  
TOP 5 folders of maximum size arranged in descending order (path and size):  
1 - /var/log/one/, 100 GB  
2 - /var/log/two/, 100 MB  
etc up to 5
Total number of files = 30
Number of:  
Configuration files (with the .conf extension) = 1 
Text files = 10  
Executable files = 5
Log files (with the extension .log) = 2  
Archive files = 3  
Symbolic links = 4  
TOP 10 files of maximum size arranged in descending order (path, size and type):  
1 - /var/log/one/one.exe, 10 GB, exe  
2 - /var/log/two/two.log, 10 MB, log  
etc up to 10  
TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file):  
1 - /var/log/one/one.exe, 10 GB, 3abb17b66815bc7946cefe727737d295  
2 - /var/log/two/two.exe, 9 MB, 53c8fdfcbb60cf8e1a1ee90601cc8fe2  
etc up to 10  
Script execution time (in seconds) = 1.5
```

## Chapter IV

Jon xohlagan hamma narsasini qilib tugatdi. Shunga qaramay, men ishda ushlanib qolishimga to’g’ri keldi, lekin bu shunga arziydi. U narsalarini yig'di va chiqish yo'lida yaqinda hamkasbi nola qilayotgan xonaga qaradi. 

`-` Salom, kirsam bo'ladimi? — Jon eshikni taqillatdi. 

`-` Ha... bir soniya. Men bu vaqtda boshqa biror kishi yo’q deb o'ylagan edim.

Eshik ochildi va qisqa suhbatdan so'ng Jon tajribasiz tizim administratoriga skriptlar bilan flesh-diskni topshirdi. Ular allaqachon xayrlashishgan va Jon ketmoqchi edi, lekin keyin u bir muhim tafsilotni esladi. 

`-` Butunlay unutibman. Men Jonman, aytgancha, ismingiz nima? 

`-` Sebastyan.
