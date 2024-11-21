<?php

namespace App\ItProjects;

class Developers
{
    public static function get($developerID, $mode)
    {
        $res = [];
        if ($mode === 'view') {
            $db = DB::getConnection();
            if ($developerID === -1) {
                $result = $db->query('call Developers_L()');
                
                foreach($result as $row) {
                    $res['developers'][] = $row;
                }
            }
            else {
                $result = $db->query("call Developers_S($developerID)");
                $res['developer'] = $result->fetch();
                $result->closeCursor();

                $result = $db->query("call Developers_ProjectsParticipatesIn($developerID)");
                
                foreach($result as $row) {
                    $res['projects'][] = $row;
                }
                $result->closeCursor();

                $result = $db->query("call Projects_AllowedForDeveloper($developerID)");
                
                foreach($result as $row) {
                    $res['availprojects'][] = $row;
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
                die("Для удаления разработчика должен быть указан его код"); 
            }
        }
        elseif ($mode === 'add') {}
        else{
            die("Режим работы с разработчиками '$mode' не поддерживается");
        }


        return $res;
    }
}