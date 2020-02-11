---
title: "Эволюция антипаттернов Java/Kotlin"
date: 2019-12-17 18:21:33
categories: [java, kotlin, patterns]
tags: [theses]
---

## В двух словах

Анти-паттерны — полная противоположность паттернам.

Если паттерны проектирования — это примеры практик хорошего программирования, то есть шаблоны решения определённых задач. То анти-паттерны — их полная противоположность, это — шаблоны ошибок, которые совершаются при решении различных задач.

Кто осведомлен, тот и вооружён!

Данный пост является лишь тезисами к прикрепленному видео.

## Источник

Докладчик: Михаил Горюнов

<div class="videoWrapper">
    <iframe width="560" height="315" src="https://www.youtube.com/embed/7be-l64jgTc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

## Михаил Горюнов - Эволюция антипаттернов Java/Kotlin

Антипаттерн - способ решения задачи неоптимально.

## Антипаттерны из доклада:

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/1.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/1.png)

- Синглтон

В синглтоне не должно быть изменяемого состояния.

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/2.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/2.png)

Это синглтон с ленивой инициализацией, т.к. классы загружаются лениво. Так же он потокобезопасный так как static однопоточный.

В котлине же убрали "муки" выбора и высекли реализацию в камне:

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/3.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/3.png)

- Синглтон с параметрами, так лучше не делать:

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/4.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/4.png)

Так показывает гугл и тоже лучше не делать (пример с билд дб):

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/5.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/5.png)

Но вместо такого синглтона лучше заюзать класс и договорится о способе передачи.

- Использование enum для switch как константа с типом

Но это плохо, т.к. в Java такой код скомпилируется, хотя мы забыли Anonymous.

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/6.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/6.png)

В Kotlin эта проблема решена с помощью when:

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/7.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/7.png)

При добавлении полей в Role код не будет компилироваться т.к. when обязует проверять все поля.

- В Kotlin есть Data class и они эффективны и несут добро если их правильно применять.

Добавления Data к Class говорит компилятору : "Пройдись по всем полям в primary конструкторе, сгенерируй на их основе hash и equals, toString, componentN, copy. ([https://kotlinlang.ru/docs/reference/idioms.html](https://kotlinlang.ru/docs/reference/idioms.html))

ComponentN нужен для Destructuring (как struct binding в ++):

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/8.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/8.png)

Антипаттерн заключается в использовании data в классах которые этого не требуют (например в классах для парса ответов через Retrofit+Gson):

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/9.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/9.png)

- Destructuring не кортежей

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/10.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/10.png)

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/11.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/11.png)

Ошибки компиляции нет, но смысловая ошибка есть.

*Совет*: Использовать только для позиционных структур + Только от разных типов

![{{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/12.png]({{ site.baseurl }}/images/posts_includes/evolve_antipatterns_java_kotlin/12.png)

- Антипаттерн: Всегда давать значения по умолчанию либо задавать null. Лучше не использовать nullable и var там где это не нужно, например создавать пользователя без имени бессмысленно.

- Антипаттерн: создавать свалку констант или глобальные константы всегда. Лучше уменьшать видимость констант на сколько это возможно.

- Антипаттерн: Не использование StringKey в java и типизированных property в Kotlin. ([https://kotlinlang.ru/docs/reference/delegated-properties.html](https://kotlinlang.ru/docs/reference/delegated-properties.html))

## Полезные ссылки

- Идиомы Kotlin - [https://kotlinlang.ru/docs/reference/idioms.html](https://kotlinlang.ru/docs/reference/idioms.html)
- Делегированные свойства (Delegated properties) - [https://kotlinlang.ru/docs/reference/delegated-properties.html](https://kotlinlang.ru/docs/reference/delegated-properties.html)
- Java and Kotlin antipattern [evolution](http://evolution.md/) - [https://gist.github.com/Miha-x64/9a8fb9fbb3fee47eb537bfc12361daa4](https://gist.github.com/Miha-x64/9a8fb9fbb3fee47eb537bfc12361daa4)
- Android Architecture Components. Часть 4. ViewModel - [https://habr.com/ru/post/334942/](https://habr.com/ru/post/334942/)
- Знакомство с android architecture components и MVVM (перевод) - [https://medium.com/@nyavorskii/знакомство-с-android-architecture-components-и-mvvm-перевод-29654672f4ab](https://medium.com/@nyavorskii/%D0%B7%D0%BD%D0%B0%D0%BA%D0%BE%D0%BC%D1%81%D1%82%D0%B2%D0%BE-%D1%81-android-architecture-components-%D0%B8-mvvm-%D0%BF%D0%B5%D1%80%D0%B5%D0%B2%D0%BE%D0%B4-29654672f4ab)
