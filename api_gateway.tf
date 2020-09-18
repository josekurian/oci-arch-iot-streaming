resource "oci_apigateway_gateway" "apigateway" {
  compartment_id = var.compartment_ocid
  endpoint_type  = "PUBLIC"
  subnet_id      = oci_core_subnet.websubnet.id
  display_name   = "apigateway"
}


resource "oci_apigateway_deployment" "apigateway_deployment" {
  compartment_id = var.compartment_ocid
  gateway_id     = oci_apigateway_gateway.apigateway.id
  path_prefix    = "/v1"
  display_name   = "apigateway_deployment"

  specification {
    routes {
      backend {
          type        = "ORACLE_FUNCTIONS_BACKEND"
          function_id = oci_functions_function.Upload2StreamFn.id
      }
      methods = ["POST"]
      path    = "/upload2stream"
    }

    routes {
      backend {
          type        = "ORACLE_FUNCTIONS_BACKEND"
          function_id = oci_functions_function.Stream2ATPFn.id
      }
      methods = ["GET"]
      path    = "/stream2atp"
    }


  }
}
