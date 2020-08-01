<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="format-detection" content="telephone=no">
    <title>@yield('title')</title>
    <link rel="apple-touch-icon" sizes="180x180" href="{{ asset('/assets/img/favicon/apple-touch-icon.png')}}">
    <link rel="icon" type="image/png" sizes="32x32" href="{{ asset('/assets/img/favicon/favicon-32x32.png')}}">
    <link rel="icon" type="image/png" sizes="16x16" href="{{ asset('/assets/img/favicon/favicon-16x16.png')}}">
    <link rel="manifest" href="{{ asset('/assets/img/favicon/site.webmanifest')}}">
    <link rel="mask-icon" href="{{ asset('/assets/img/favicon/safari-pinned-tab.svg')}}" color="#5bbad5">
    <meta name="msapplication-TileColor" content="#da532c">
    <meta name="theme-color" content="#ffffff">
    <link rel="stylesheet" href="{{ asset('/css/app.css') }}">
</head>
<body class="body">
@yield('content')
</body>

<script src="{{ mix('/js/app.js') }}"></script>
