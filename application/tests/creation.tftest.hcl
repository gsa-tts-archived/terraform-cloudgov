mock_provider "cloudfoundry" {}

variables {
  cf_org_name          = "gsa-tts-devtools-prototyping"
  cf_space_name        = "terraform-cloudgov-ci-tests"
  name                 = "fac-app"
  branch_name          = "main"
  github_org_name      = "gsa-tts"
  github_repo_name     = "fac"
  src_code_folder_name = "backend"
  buildpacks           = ["https://github.com/cloudfoundry/apt-buildpack.git", "https://github.com/cloudfoundry/python-buildpack.git"]
  service_bindings = jsonencode([
    {
      service_instance = "my-service-instance"
    },
    {
      service_instance = "my-service-instance-2"
    }
  ])
  environment_variables = {
    ENV_VAR  = "1"
    ENV_VAR2 = "2"
  }
}

#TODO: More Testing

run "application_tests" {
  assert {
    condition     = output.app_id == cloudfoundry_app.application.id
    error_message = "Output id must match the app id"
  }
  assert {
    condition     = "${var.name}.app.cloud.gov" == output.endpoint
    error_message = "Endpoint output must match the app route endpoint"
  }
  assert {
    condition     = lookup(cloudfoundry_app.application.environment, "REQUESTS_CA_BUNDLE", "/etc/ssl/certs/ca-certificates.crt") != null
    error_message = "The REQUESTS_CA_BUNDLE environment variable should not be null by default"
  }
  assert {
    condition     = cloudfoundry_app.application.buildpacks != null
    error_message = "The application buildpacks should not be empty"
  }
  assert {
    condition     = cloudfoundry_app.application.service_bindings != null
    error_message = "The application should have services bound by default"
  }
}

run "src_tests" {
  assert {
    condition     = cloudfoundry_app.application.path == "${path.module}/${data.external.app_zip.result.path}"
    error_message = "The path for the zip should be in the module path"
  }
}
