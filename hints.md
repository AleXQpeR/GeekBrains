# Установка Git

GitHub предоставляет оконное приложение с графическим интерфейсом для выполнения основных операций с репозиторием, и консольную версию Git с автоматическими обновлениями для расширенных сценариев работы.

## GitHub Desktop
[desktop.github.com](https://desktop.github.com/)

Дистрибутивы Git для систем Linux и POSIX доступны на официальном сайте Git SCM.
## Git для всех платформ
[git-scm.com](https://git-scm.com.com/)

# Первоначальная настройка
###  Настройка информации о пользователе для всех локальных репозиториев

```
git config --global user.name "[имя]"
```
* Устанавливает имя, которое будет отображаться в поле автора у выполняемых вами коммитов

```
git config --global user.email "[адрес электронной почты]"
```
* Устанавливает адрес электронной почты, который будет отображаться в информации о выполняемых вами коммитах

# Создание репозитория
<<<<<<< HEAD
Что бы создать репозиторий введите
=======
### Создание нового репозитория или получение его по существующему URL-адресу

```
git init [название проекта]
```
* Создаёт новый локальный репозиторий с заданным именем

```
git clone [url-адрес]
```
* Скачивает репозиторий вместе со всей его историей изменений
>>>>>>> repo_create

# Внесение изменений
### Просмотр изменений и создание коммитов (фиксация изменений)

```
git status
```
* Перечисляет все новые или изменённые файлы, которые нуждаются в фиксации

```
git diff
```
* Показывает различия по внесённым изменениям в ещё не проиндексированных файлах

```
git add [файл]
```
* Индексирует указанный файл для последующего коммита

```
git diff --staged
```
* Показывает различия между проиндексированной и последней зафиксированной версиями файлов

```
git reset [файл]
```
* Отменяет индексацию указанного файла, при этом сохраняет его содержимое

```
git commit -m "[сообщение с описанием]"
```
* Фиксирует проиндексированные изменения и сохраняет их в историю версий

# Коллективная работа

# Операции с файлами

# Игнорирование некоторых файлов

# Сохранение фрагментов
### Сохранение и восстановление незавершённых изменений
---
```
git stash
```
* Временно сохраняет все незафиксированные изменения отслеживаемых файлов

```
git stash pop
```
* Восстанавливает состояние ранее сохранённых версий файлов

```
git stash list
```
* Выводит список всех временных сохранений

```
git stash drop
```
* Сбрасывает последние временно сохранённыe изменения

# Просмотр истории

# Откат коммитов

# Синхронизация с удалённым репозиторием
