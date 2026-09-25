Как работает app Launcher.

1. Загружается Quickshell. Как только загрузилась панель `appLauncher` происходит следующее:

   1. очищение модели `appsModel`
   2. запускается `desktopsProcess`(`sh -c `) для получения установленных приложений.
   3. запускается `lauchedAppsFileProcess` (`touch /home/pasha/.config/quickshell/launched_apps.json`) для создания файла с **часто запускаемыми приложениями**.
2. При нажатии клавиши `SUPER + A`  панель  становится `visible = true`, но при этом **прозрачной** и занимающей весь экран (для предотвращения потери фокуса).
3. отображаем `поле поиска` и ниже - `область приложений` сначала отображаются наиболее **часто запускаемые**, потом остальные - **в алфавитном порядке**.

### Задача 1 (done):

**при запуске** приложения - заново перерисовывать все приложения в `области приложений`

т.е заново прочитать файл `launched_apps.json` и  заново выполнить сортировку (сначала **часто запускаемые**, потом - остальные **в алфавитном порядке**).

### Задача 2 (DONE):

переименовать:

	HorizontalPanel -> HorizontalBar

	AppPanel -> ApplicationLauncher

	NotificationPanel -> Notification

	diretory panels -> modules

### Task 3 (DONE):

Cделать так, чтобы консольные приложения (Neovim, Htop и др.) запускались через Application Launcher (Super + A).

Нужно распознать что  это консольное приложение.

### Task 4 (DONE):

вынести файл `launched_apps.json`  в `~/.local/share/quickshell/launched_apps.json`

### Task 5 (DONE):

добавить возможность убрать application launcher путём нажатия `Esc`

### Task 6 (DONE):

если `workspace` становится `urgent` подсвечивать цифру красным.

### Task 7 (DONE):

не использовать desktop файлы у которых `NoDisplay=true`, а также скрытые приложения `Hidden=true`, а приложения под конкретный дистрибутив `OnlyShowIn=XFCE;GNOME;Unity;Pantheon;X-Cinnamon;`и скрытые от конкретного дистрибутива `NotShowIn=KDE;GNOME;` не показываются приложения независимо от параметра.

### Task 8 (DONE):

При нахождении на последнем элементе нажимаем  `Down` переходим на самый верх.

При нахождении на первом элементе нажимаем  `Up` переходим на самый низ.

### Task 9 (pending):

Решить баг

```Shell
 WARN: Could not load icon "hwloc" at size QSize(30, 30) from request
  WARN: Could not load icon "preferences-system-network" at size QSize(30, 30) from request
  WARN: Could not load icon "network-wired" at size QSize(30, 30) from request
  WARN: Could not load icon "hwloc" at size QSize(30, 30) from request
  WARN: Could not load icon "preferences-system-network" at size QSize(30, 30) from request
  WARN: Could not load icon "network-wired" at size QSize(30, 30) from request
  WARN: Could not load icon "network-wired" at size QSize(30, 30) from request
```

### Task 10 (pending):
