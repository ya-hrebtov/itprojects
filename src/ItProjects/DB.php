<?php

namespace App\ItProjects;

class DB
{
    public static function getConnection() 
    {
        try {
            $db = new \PDO("mysql:host={$_ENV['dbServer']};dbname={$_ENV['dbName']};",  $_ENV['dbUser'], $_ENV['dbPass']);
            $db->exec("set names utf8");
        }
        catch (\PDOException $e) {
            echo "Не удается подключиться к БД ({$_ENV['dbName']}@{$_ENV['dbServer']}): " . $e->getMessage();
            die();
        }    

        return $db;
    }
}