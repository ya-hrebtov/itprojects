<?php

namespace App\ItProjects;

class Index
{
    public static function get()
    {
        return [
            [
                'sectionName' => 'Проекты',
                'sectionLink' => 'projects/',
            ],
            [
                'sectionName' => 'Разработчики',
                'sectionLink' => 'developers/',
            ],
        ];
    }
}