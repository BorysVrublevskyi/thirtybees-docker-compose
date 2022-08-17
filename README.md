# ThirtyBees Docker compose

[ThirtyBees e-commerce CMS](https://github.com/thirtybees/thirtybees) containerized

Right now it includes
 - php-fpm
 - nginx
 - mariadb
 - memcached

Containers build - Ok

Website install - failing with error:

```
Create settings.inc file
Create database tables
Create default shop and languages
Populate database tables
An error occurred during installation...
You can use the links on the left column to go back to the previous steps, or restart the installation process by clicking here.

Uncaught Error: Call to undefined function imagecreatefromjpeg() in /var/www/html/classes/ImageManager.php:316 Stack trace: #0 /var/www/html/classes/ImageManager.php(275): ImageManagerCore::create(2, '/var/www/html/i...') #1 /var/www/html/install/models/install.php(606): ImageManagerCore::resize('/var/www/html/i...', '/var/www/html/i...', '80', 80) #2 /var/www/html/install/models/install.php(560): InstallModelInstall->copyLanguageImages('en') #3 /var/www/html/install/controllers/http/process.php(188): InstallModelInstall->populateDatabase(Array) #4 /var/www/html/install/controllers/http/process.php(100): InstallControllerHttpProcess->processPopulateDatabase() #5 /var/www/html/install/classes/controllerHttp.php(207): InstallControllerHttpProcess->process() #6 /var/www/html/install/trystart.php(34): InstallControllerHttp::execute() #7 /var/www/html/install/index.php(56): require_once('/var/www/html/i...') #8 {main} thrown
```

The reason can be in php-fpm modules (something missing?). Have no time to debug it.