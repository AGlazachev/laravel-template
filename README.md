## Разворачивание проекта

- [Устанавливаем и запускаем Docker](https://www.docker.com/).
- Стартуем контейнеры `docker-compose up -d`
- Устанавливаем все зависимости composer `docker-compose exec app composer update`
- `docker-compose exec app cp .env.dev .env`
- `docker-compose exec php artisan key:generate`
- Устанавливаем пакеты `npm i`
- `npm run prod` или `npm run watch` собираем или запускаем проект
- `docker-compose exec app php artisan storage:link` не забываем о прилинковке
