---
title: "Что спрашивают на собеседованиях в компаниях на должности С++ разработчика"
date: 2020-05-11 12:54:33
categories: [c++, interview]
tags: [theses]
---

Что спрашивают на собеседованиях в компаниях на должности С++ разработчика?

Table of Contents:
- [Что должен знать каждый C++ программист или Как проводить собеседование](#что-должен-знать-каждый-c-программист-или-как-проводить-собеседование)
  - [Алгоритмы и структуры данных](#алгоритмы-и-структуры-данных)
  - [Компиляторы](#компиляторы)
  - [С++](#с)
  - [Стандартная библиотека С++](#стандартная-библиотека-с)
  - [Шаблоны С++](#шаблоны-с)
  - [Железо и ОС](#железо-и-ос)
  - [Многопоточность](#многопоточность)
  - [Сеть](#сеть)
  - [ООП](#ооп)
  - [Инфраструктура](#инфраструктура)
  - [Другие языки](#другие-языки)
  - [Математика](#математика)
  - [Полезные материалы](#полезные-материалы)


<div class="videoWrapper">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/QLqySEpEKW8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

# Что должен знать каждый C++ программист или Как проводить собеседование

Что спрашивают на собеседованиях в компаниях на должности С++ разработчика?

Данный вопрос задают гостям, каждый из которых частенько собеседует С++ разработчиков различного уровня. 

Присутствуют представители от yandex, wargaming, ReSharper C++ и один из организаторов C++ moscow Александр.

## Алгоритмы и структуры данных

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled.png)

Алгоритмы спрашивают во всех компаниях.

Писать на бумажке код могут не все, главно рассуждать правильно.

Важно уметь определять вычислительную сложность - n logn n2 экспотенциальная.

Все стараются не спрашивать алгоритмы открыто. А прятать их за задачами.

**Пример задачи**: Представьте что у вас есть комплишн в ide и собрал миллион элементов, а показывает в подсказках первые 20. Как найти 20 самых подходящих (критерий самый подходящий это поле в самом элементе).

И как ответ хотят услышать Partial Sort и что за линейное время можно найти 20 лучших. Еще круче если рассказать подробное и реализовать.

Важно знать как в stl реализованы контейнеры и сколько стоят вставки, доступ к элементам.

**Из остылок почитать:**

- [Splay-дерево]([https://neerc.ifmo.ru/wiki/index.php?title=Splay-дерево](https://neerc.ifmo.ru/wiki/index.php?title=Splay-%D0%B4%D0%B5%D1%80%D0%B5%D0%B2%D0%BE))
- [АВЛ-дерево]([https://ru.wikipedia.org/wiki/АВЛ-дерево](https://ru.wikipedia.org/wiki/%D0%90%D0%92%D0%9B-%D0%B4%D0%B5%D1%80%D0%B5%D0%B2%D0%BE))

**Из интересных задач**: Есть утилита которая quick sort'ом сортирует данные. Как подобрать данные для наихудшего исхода.

## Компиляторы

Знать глубоко как устроенны и работают компиляторы нужно только если вы его разрабатываете.

Знать как устроен, какие уровни есть будет большим плюсом.

Но куда важнее это то с каким компилятором вы работали, флаги тд, что ковыряли.

Какие оптимизации пробывали.

В каких средах.

## С++

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%201.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%201.png)

**Из остылок почитать:**

- [C++ vtables. Часть 1 (basics + multiple Inheritance)]([https://habr.com/ru/company/otus/blog/479802/](https://habr.com/ru/company/otus/blog/479802/))
- [C++ vtables. Часть 2 (Virtual Inheritance + Compiler-Generated Code)]([https://habr.com/ru/company/otus/blog/480610/](https://habr.com/ru/company/otus/blog/480610/))

**Hacker’s Delight** (Алгоритмические трюки для программистов) - [https://doc.lagout.org/security/Hackers Delight.pdf](https://doc.lagout.org/security/Hackers%20Delight.pdf). На русском (но 1ая версия) - [http://rsdn.org/res/book/prog/worren.xml](http://rsdn.org/res/book/prog/worren.xml).

В компании геймдева особо про современный с++ не спрашивают.

В ReSharper C++ спрашиваю, но тоже "выводя" на тему вопросами "Какие фичи современные языка С++ вам нравятся"? Интересно, что бы я ответил... Наверное optional, variant и дедуцирование шаблона из конструктора.

**Из примеров задач**: Напишите сигнатуру std move

**Из вопросов**:

- Почему RTTI не работает
- Почему exception такие как с ними жить
- Как можно не жить с exception

> Когда то я разберусь с семнатикой перемещения...

## Стандартная библиотека С++

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%202.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%202.png)

Если есть понимание как работает, как устроен внутри вектор (любой контейнер), как взаимодействует с кэшом - это большой плюс. 

## Шаблоны С++

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%203.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%203.png)

Шаблоны спрашивают, но как часть языка.

## Железо и ОС

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%204.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%204.png)

Если человек осведомлен как всё перечисленной работает, хотя бы в "общем", это не сомненный плюс. Но все эти темы скорее узкоспециализированы и нужны не всем.

**Пример вопросов из решарпер**:

- Вот у тебя есть struct из bool и int. Каков ее sizeof?
- Вот у нас есть квадратная матрица. Мы ее проходим по строкам или по столбцам. Какие у вас ожидания от быстродействия? Вопрос отсылка к кешам.

## Многопоточность

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%205.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%205.png)

Я удивлён, но никто из спикеров на собеседованиях не спрашивают об этом, если нет какой-то узкоспециализированной задачи.

Цитата:

> Потому что никто и не знает как на самом деле работает mutex. И твоя задача понять откуда deadlock, а не как устроен mutex.

## Сеть

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%206.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%206.png)

Тоже цитата:

> Книгу таненбаума стоит прочитать.

Если человек понимает как сет. стек работает - это большой плюс.

## ООП

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%207.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%207.png)

Я удивлен снова, но не просят глубоких знаний. Мне кажется спикеры просто устали уже.

Моё лично мнение - архитектура не менее алгоритмов важна, если не важнее. Т.к. спроектированый код - легче читается, легче для понимания и поддержки, расширения.

## Инфраструктура

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%208.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%208.png)

Подробно про это никто не спрашивают, просто уточняют что использовал, как, согласно проекту куда хантят.

## Другие языки

![{{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%209.png]({{ site.baseurl }}/images/posts_includes/every_cpp_dev_should_know/Untitled%209.png)

Будет плюсом, но, цитата:

> За 3 месяца можно выучить

## Математика

Под специфичные задачи - могут спрашивать.

Но если человек будет jsonчики перекладывать, то нет.

## Полезные материалы

- [The Archive of Interesting Code]([https://www.keithschwarz.com/interesting/](https://www.keithschwarz.com/interesting/))
- [Teaching Tree Online Knowledge: Rapid and Unconstrained]([http://teachingtree.co/cs](http://teachingtree.co/cs))
- [GeeksForGeeks]([https://www.geeksforgeeks.org/](https://www.geeksforgeeks.org/))
- [C++ Notes for Professionals book]([https://books.goalkicker.com/CPlusPlusBook/](https://books.goalkicker.com/CPlusPlusBook/))
- [Десятка лучших докладов C++ Russia и плейлист конференции в открытом доступе]([https://habr.com/ru/company/jugru/blog/462939/](https://habr.com/ru/company/jugru/blog/462939/))