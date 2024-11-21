<?php

namespace App\ItProjects;

class Proj
{
    public static function get($projectID, $mode)
    {
        $res = [];
        if ($mode === 'view') {
            $db = DB::getConnection();
            if ($projectID === -1) {
                $db = DB::getConnection();
                $result = $db->query('call Projects_L()');
                
                foreach($result as $row) {
                    $res['projects'][] = $row;
                }
            }
            else {
                $result = $db->query("call Projects_S($projectID)");
                $res['project'] = $result->fetch();
                $result->closeCursor();

                $res['developers'] = [];
                $result = $db->query("call Projects_DevelopersWorkingOn($projectID)");
                
                foreach($result as $row) {
                    $res['developers'][] = $row;
                }
                $result->closeCursor();

                $result = $db->query("call Developers_AllowedForProject($projectID)");
                
                foreach($result as $row) {
                    $res['availdevelopers'][] = $row;
                }

                /*
                echo('<pre>');
                print_r($res);
                die();
                */
            }
        }
        elseif ($mode === 'del') {
            if ($projectID === -1) {
                die("Для удаления проекта должен быть указан его код"); 
            }
        }
        elseif ($mode === 'add') {}
        else{
            die("Режим работы с проктами '$mode' не поддерживается");
        }


        return $res;
    }
}