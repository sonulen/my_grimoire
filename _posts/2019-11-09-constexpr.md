---
title: "Полезный constexpr"
date: 2019-09-11 12:54:33
categories: [c++]
tags: [theses]
---

В C++11 добавили новое ключевое слово — constexpr. Выглядит оно весьма невзрачно, да и на первый взгляд кажется, что смысла в нём маловато…
Для чего оно нужно, какие у него тайные супер способности и какую роль оно сыграет в дальнейшем развитии языка C++ — именно об этом мы и поговорим.

Данная статья является лишь тезисами к прикрепленному видео.

Table of Contents:
- [Источник](#источник)
- [Антон Полухин - Полезный constexpr](#антон-полухин---полезный-constexpr)
- [C++20](#c20)
- [Далекий мир в котором в плюсы завезли рефлексию](#далекий-мир-в-котором-в-плюсы-завезли-рефлексию)

## Источник

Докладчик: Антон Полухин (Яндекс).

<div class="videoWrapper">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/yZsWgufydCU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Антон Полухин - Полезный constexpr

6:40 Если в функции создавать статик который на компайл тайме не посчитать - компилятор возьмет положит переменную в бинарник куда то (bss) проинициализирует 0. потом когда дойдет до вызова этой функции компилятор такой - а, она не проинициализированна, захватит reсursive mutex, проинициализирует, отпустит мутек и вернется.

8:20 Constexpr конструктор если есть и все параметры входные в него constexpr известны - то стандарт говорит о том что эти переменные необходимо статически инициализировать (на этапе компиляции). Получается частично решается проблема порядка инициализации.

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-32-07-223_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-32-07-223_com.google.android.youtube.png)

Сonstexpr считает фронтенд компилятора - С++ сторона.

Переполнение знакового числа в С++ - UB (неопределенное поведение).

Надо проверить код: (по убирать constexpr):

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-37-39-155_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-37-39-155_com.google.android.youtube.png)

## C++20

Consexpr new

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-39-43-293_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-39-43-293_com.google.android.youtube.png)

New + vector хотят сделать constexpr. С учетом того что new в функции выделенный будет в ней же освобожден.

Они пошли дальше: можно возвращать проаллоцированную память и она как бы смапится (будет выделенна будто статик) сразу в бинарнике. Для реализации подобного функционала компилятор будет "проверять" (будто бы вызывать) деструктор объекта и следить что память вся будет "когда-то" очищена.

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-43-53-912_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-43-53-912_com.google.android.youtube.png)

На момент С++17 все std::string инициализируются динамически - соотв. медленно. Constexpr new решит это.

20:00 Во многих языках регулярки работают следующим образом: компилятор по регулярному выражению строит огромный (динамически сконфигурированный) недетерминированный конечный автомат. На след. этапе недетерминированный конечный автомат оптимизируется до детерминированного.

В с++ это не может выполнится (пока) на этапе компиляции и получается в рантайме ты тратишь время на его создание, инициализацию переменной regex ( в случае static const один раз за все время),но!

Все изменения static переменных выполняются из под recursive mutex!

С constepxr new регулярки смогут считать так же на этапе компиляции.

26:00 В с++17 добавили поисковые движки. (их минус в том что они конструируются долго, ищут быстро (иногда нет)). С 20 и constexpr должно работать на компиляции.

Пока что constexpr не обязует компилятор ни к чему!

## Далекий мир в котором в плюсы завезли рефлексию

27:00

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-58-06-497_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-58-06-497_com.google.android.youtube.png)

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-58-23-474_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-22-58-23-474_com.google.android.youtube.png)

![{{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-23-00-17-900_com.google.android.youtube.png]({{ site.baseurl }}/images/posts_includes/anton_useful_constexpr/Screenshot_2019-10-08-23-00-17-900_com.google.android.youtube.png)

Хотят добавить обязательный contexpr - ```constexpr!```.

Этот оператор будет говорить компилятору типо чел, это должно быть оптимизированно только фронтендом и не должно попасть в middle end.

Работа с файлами на компиляции. Говорит о том что можно будет вшивать данные из файла ( например шейдеры) прямо в бинарь.
