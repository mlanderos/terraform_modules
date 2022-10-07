# inputs for module

variable "resourceGroupName" {
  type = string
  #TODO: length 3-63
}

variable "resourceGroupLocation" {
  type = string
}

variable "resourceGroupTags" {
  type = map(string)
}
