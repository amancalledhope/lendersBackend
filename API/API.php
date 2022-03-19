<?php

include_once "../controller/UserController.php";


if (isset($_GET["api_argument"])) {

    $api_argument = $_GET["api_argument"];

    if ($api_argument == 'all_guitars') {

        $guitarController = new GuitarController();
        $allGuitars = $guitarController->getAllGuitars();

        $jsonData = array();

        foreach ($allGuitars as $obj) {

            $guitarObj = $guitarController->getGuitar($obj->getGuitarId());


        }

    }

}

if (isset($_POST["action"])) {
    $post_action = $_POST["action"];

    if ($post_action == 'authenticate') {
        $userName = $_POST['userName'];
        $password = $_POST['password'];

        $controller = new UserController();
        $result = $controller->authenticateUser($userName, $password);

        if ($result != "0") {

            $SObj = new stdClass();
            if ($result->getUserType() == 1) {

                $supervisorController = new SupervisorController();
                $supervisorObj = $supervisorController->getSupervisorByUserId($result->getUserId());

                $SObj->supervisorId = $supervisorObj->getSupervisorId();
                $SObj->firstName = $result->getFirstName();
                $SObj->lastName = $result->getLastName();
                $SObj->phone = $result->getPhone();
                $SObj->email = $result->getEmail();
                $SObj->userType = $result->getUserType();
            }
            if ($result->getUserType() == 2) {
                $teacherController = new TeacherController();
                $teacherObj = $teacherController->getTeacherByUserId($result->getUserId());

                $SObj->teacherId = $teacherObj->getTeacherId();

                $SObj->supervisorId = $teacherObj->getSupervisor()->getSupervisorId();
                $SObj->supervisorName = $teacherObj->getSupervisor()->getMUser()->getFirstName() . " " . $teacherObj->getSupervisor()->getMUser()->getLastName();

                $SObj->firstName = $result->getFirstName();
                $SObj->lastName = $result->getLastName();
                $SObj->phone = $result->getPhone();
                $SObj->email = $result->getEmail();
                $SObj->userType = $result->getUserType();

                $SObj->mClassName = $teacherObj->getMClass()->getGrade() . "" . $teacherObj->getMClass()->getSection();
                $SObj->mClassNumberMales = $teacherObj->getMClass()->getNumberOfMales();
                $SObj->mClassNumberFemales = $teacherObj->getMClass()->getNumberOfFemales();
                $SObj->classId = $teacherObj->getMClass()->getClassId();


                $SObj->schoolName = $teacherObj->getMClass()->getSchool()->getSchoolName();

                $SObj->subjectId = $teacherObj->getSubject()->getSubjectId();
                $SObj->subjectName = $teacherObj->getSubject()->getSubjectName();
            }

            die(json_encode(array('return' => $SObj)));
        } else {
            die(json_encode(array('return' => 0)));
        }
    }

    if ($post_action == 'addUser') {
        $userName = $_POST['userName'];
        $nrc = $_POST['nrc'];
        $phoneNumber = $_POST['phoneNumber'];
        $password = $_POST['password'];
        $email = $_POST['email'];

        $controller = new UserController();
        $userId = $controller->addUser($userName, $nrc, $email, $phoneNumber, $password);
        $result = $userId;
        die(json_encode(array('return' => $result)));
    }

}

?>