---
title: "Спецификаторы, квалификаторы и шаблоны"
date: 2020-06-18 12:54:33
categories: [c++]
tags: [theses]
---

Уже в С++98 у нас были const, volatile, static, extern, inline и, конечно, шаблоны. В С++11 добавились thread_local, constexpr, а также extern для шаблонов. В С++14 добавились шаблоны переменных. В С++17 — inline переменные. В С++20 обещают подвезти consteval и constinit. А вы когда-нибудь задумывались, что такое template static inline thread_local constexpr const volatile переменная?

В этом докладе Михаил попытается разложить по полочкам всё это многообразие ключевых слов. Вспомним про linkage, storage duration и инстанциации шаблонов (и что изменится с приходом модулей в С++20). Разберёмся, какая связь между template и inline, между static и constexpr. Поймём, зачем нам extern, когда у нас есть inline. И осознаем, как нам потребовалось почти 20 лет, чтобы научиться нормально объявлять константы.

Table of Contents:

- [Сборка С/С++ программ](#сборка-сс-программ)
- [Что такое объявление и определение](#что-такое-объявление-и-определение)
- [Linkage](#linkage)
- [Storage Duration](#storage-duration)
- [Волшебный static](#волшебный-static)
- [Const-qualified variables](#const-qualified-variables)
- [Inline переменные](#inline-переменные)
- [Constexpr функции](#constexpr-функции)
- [No diagnostic required](#no-diagnostic-required)
- [Комбинации storage duration и linkage](#комбинации-storage-duration-и-linkage)
- [Алгоритм как определять storage duration](#алгоритм-как-определять-storage-duration)
- [Extern](#extern)
- [На примерах](#на-примерах)
- [Шаблоны](#шаблоны)
- [Inline functions templates](#inline-functions-templates)
- [Объявление явной инстанции шаблона](#объявление-явной-инстанции-шаблона)
- [Константы](#константы)
- [C++20](#c20)
- [Рекомендации](#рекомендации)

<div class="videoWrapper">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/G_jcBrrYPAs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Сборка С/С++ программ

Единицы трансляции (translation unit) - сущность формируемая precrocessor, компилируя их мы получаем объектные файлы.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled.png)

## Что такое объявление и определение

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%201.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%201.png)

## Linkage

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%202.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%202.png)

Второй пример (a'.cpp) не соберется из-за `static`, т.к. это изменит линковку функции, и она будет видна только в своей единице трансляции.

Всего в C++ есть 3 вида linkage:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%203.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%203.png)

External - доступна во всех единицах трансляции.

Internal - только в текущей трансляции.

No - только в текущей области видимости.

## Storage Duration

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%204.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%204.png)

В первом случаем переменная всегда будет 0, во втором же переменная проинициализируется в первый раз 0 и память под нее будет выделена в начале программы, а далее все время будет "жить" и хранить значение.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%205.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%205.png)

## Волшебный static

`Static` особенное слово, в зависимости от контекста оно может влиять на линковку, а может на `storage duration.`

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%206.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%206.png)

## Const-qualified variables

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%207.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%207.png)

Любая переменная объявленная на уровне пространства имет `internal linkage` если он `cv-qualified`. Но в примере ругается линковщик на то, что `name` это указатель на константные данные, но указатель не `const`.

`Constexpr` влечет за собой const:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%208.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%208.png)

Пример работы `internal linkage`:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%209.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%209.png)

## Inline переменные

`Inline` работает следующим образом: в каждой единице трансляции на этапе компиляции создается свой объект, но этот символ при попадании в объектник получит отметку `weak`, и линковщик потом выберет только один.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2010.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2010.png)

## Constexpr функции

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2011.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2011.png)

Однако, если функция constexpr qualified то она становится `inline` .

В современном `C++` `inline` это скорее не про то, что функция будет встраиваться, а про то,что это будет `external (weak) linkage` и комплятор позаботиться о том, что это функция будет одна.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2012.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2012.png)

## No diagnostic required

В `C++` представленна ситуация ведет к неопределенном поведению и никак не обрабатывается компилятором. И в каждом компиляторе будет свой вывод.

Такие ситуации слишком сложно диагностировать и принято решение не нагружать компиляторы.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2013.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2013.png)

Решение данной проблемы заключается в использовании анонимных `namespace`. Ничего из анонимного пространства имен не торчит наружу. И тогда эти структуры и функции будут иметь `internal linkage`.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2014.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2014.png)

## Комбинации storage duration и linkage

Легенда к изображениям:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2015.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2015.png)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2016.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2016.png)

## Алгоритм как определять storage duration

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2017.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2017.png)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2018.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2018.png)

## Extern

До появления `inline` для получения `external linkage` для переменных использовался `extern`.

Но у него есть преимущество, если с inline объект помещался бы в каждый объектный файл, то `extern` приводит к тому, что мы получаем _определение_ переменной, а инициализируется и создается она единожды.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2019.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2019.png)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2020.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2020.png)

## На примерах

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2021.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2021.png)

## Шаблоны

Не бывает шаблонных сущностей, бывают шаблоны сущностей.

При создании шаблонной сущности происходит неявная инстанциация шаблона.

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2022.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2022.png)

Если вы хотите убедиться, что у вас действительно один объект, используйте `inline`

(отличный спобос создания констант)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2023.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2023.png)

## Inline functions templates

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2024.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2024.png)

## Объявление явной инстанции шаблона

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2025.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2025.png)

## Константы

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2026.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2026.png)

Вот best practice объявления констант:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2027.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2027.png)

Но когда введут модули и у нас не будет h файлов, все эти сложности уйдут:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2028.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2028.png)

Алгоритм выбора квалификаторов для констант:

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2029.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2029.png)

## C++20

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2030.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2030.png)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2031.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2031.png)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2032.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2032.png)

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2033.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2033.png)

## Рекомендации

![{{ site.baseurl }}/images/posts_includes/specifications/Untitled%2034.png]({{ site.baseurl }}/images/posts_includes/specifications/Untitled%2034.png)
