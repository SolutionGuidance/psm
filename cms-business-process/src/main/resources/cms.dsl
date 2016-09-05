[condition][] This validation is performed on {tab}=LookupEntry(type == "FieldGroup", value == {tab}) $report: ErrorReporter() 
[condition][] The individual does not have a {field} = IndividualApplicantType({field} == null || {field} matches "^[\\s]*$")
[condition][] first name =firstName
[condition][] last name =lastName
[condition][] social security number =socialSecurityNumber
[condition][] page "Personal Information" = UISection.PERSONAL_INFORMATION.value()
[consequence][]Raise error on {path} with message {message}=$report.addError({path}, "00001", {message});
[consequence][]"Provider First Name"="/ProviderInformation/ApplicantInformation/PersonalInformation/FirstName"
[consequence][]"Provider Last Name"="/ProviderInformation/ApplicantInformation/PersonalInformation/LastName"
[consequence][]"Provider SSN"="/ProviderInformation/ApplicantInformation/PersonalInformation/SocialSecurityNumber"
