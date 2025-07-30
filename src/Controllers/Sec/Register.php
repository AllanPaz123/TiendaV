<?php

namespace Controllers\Sec;

use Controllers\PublicController;
use \Utilities\Validators;
use \Controllers\Error;
use Exception;

class Register extends PublicController
{
    private $txtEmail = "";
    private $txtPswd = "";
    private $txtUsername = "";
    private $errorUsername = "";
    private $errorEmail = "";
    private $errorPswd = "";
    private $hasErrors = false;
    public function run(): void
    {

        if ($this->isPostBack()) {
            $this->txtEmail = $_POST["txtEmail"];
            $this->txtUsername = $_POST["txtUsername"];
            $this->txtPswd = $_POST["txtPswd"];
            //validaciones
            if (!(Validators::IsValidEmail($this->txtEmail))) {
                $this->errorEmail = "El correo no tiene el formato adecuado";
                $this->hasErrors = true;
            }
            if (!(Validators::IsValidName($this->txtUsername))) {
                $this->errorUsername = "El nombre de usuario debe tener al menos 3 caracteres y no contener símbolos especiales.";
                $this->hasErrors = true;
            }
            if (!Validators::IsValidPassword($this->txtPswd)) {
                $this->errorPswd = "La contraseña debe tener al menos 8 caracteres una mayúscula, un número y un caracter especial.";
                $this->hasErrors = true;
            }

            if (!$this->hasErrors) {
                try {
                    if (\Dao\Security\Security::newUsuario($this->txtEmail, $this->txtUsername, $this->txtPswd)) {
                        \Utilities\Site::redirectToWithMsg("index.php?page=sec_login", "¡Usuario Registrado Satisfactoriamente!");
                    }
                } catch (Error $ex) {
                    die($ex);
                }
            }
        }
        $viewData = get_object_vars($this);
        \Views\Renderer::render("security/sigin", $viewData);
    }
}
