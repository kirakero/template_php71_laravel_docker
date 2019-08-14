#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

echo "= Install Laravel"
mkdir $PWD/_temp
composer create-project laravel/laravel $PWD/_temp
cp -rf $PWD/_temp/ $PWD
rm -rf $PWD/_temp/

echo "= Copy Template"
cp -rf $DIR/template/ $PWD/

echo "= Setup .env"
cp .env.example .env
php artisan key:generate

echo "= Setup JWT"
composer require tymon/jwt-auth:dev-develop#63698d3
patch config/app.php < $DIR/patch/00-jwt.patch
php artisan vendor:publish --provider="Tymon\JWTAuth\Providers\LaravelServiceProvider"
php artisan jwt:secret
patch -p0 < $DIR/patch/01-jwt.patch
php artisan make:controller AuthController
cp $DIR/patch/02-AuthController.php app/Http/Controllers/AuthController.php

