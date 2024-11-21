<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

class ItProjectsController extends AbstractController
{
    #[Route('/')]
    public function index(): Response
    {
        return $this->render('itprojects/index.html.twig', [
            'sections' => \App\ItProjects\Index::get(),
        ]);
    }
    
    #[Route('/projects/{projectID}', defaults: ['projectID' => -1], requirements: ['projectID' => '\d+'])]
    public function itProjects(int $projectID): Response
    {
        if ($projectID === -1) {
            return $this->render('itprojects/allprojects.html.twig', \App\ItProjects\Proj::get($projectID, 'view'));
        }    
        else {
            return $this->render('itprojects/project.html.twig', \App\ItProjects\Proj::get($projectID, 'view'));
        }    
    }

    #[Route('/projects/del/{projectID}', requirements: ['projectID' => '\d+'])]
    public function itProjectsDel(int $projectID): Response
    {
        return $this->render('itprojects/projects.html.twig', [
            'projects' => \App\ItProjects\Proj::get($projectID, 'del'),
        ]);
    }

    #[Route('/developers/{developerID}', defaults: ['developerID' => -1], requirements: ['developerID' => '\d+'])]
    public function itDevelopers(int $developerID): Response
    {
        if ($developerID === -1) {
            return $this->render('itprojects/alldevelopers.html.twig', \App\ItProjects\Developers::get($developerID, 'view'));
        }
        else {
            return $this->render('itprojects/developer.html.twig', \App\ItProjects\Developers::get($developerID, 'view'));
        }
    }

    #[Route('/developers/del/{developerID}', defaults: ['developerID' => -1], requirements: ['developerID' => '\d+'])]
    public function itDevelopersDel(int $developerID): Response
    {
        return $this->render('itprojects/developers.html.twig', [
            'developers' => \App\ItProjects\Developers::get($developerID, 'del'),
        ]);
    }
}
