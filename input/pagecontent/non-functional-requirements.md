
These requirements define the qualities and attributes of the ePrescription system that ensure it is secure, reliable, usable, interoperable, and maintainable. They are categorized for clarity.

### Table of Non-Functional Requirements

| **Requirement ID**   | **Category**                          | **Non-Functional Requirement** |
|----------------------|----------------------------------------|---------------------------------|
| PD.NFXNREQ.001       | Security – confidentiality             | Provide password-protected access for authorized users |
| PD.NFXNREQ.002       | Security – confidentiality             | Provide a means to ensure confidentiality and privacy of personal health information |
| PD.NFXNREQ.003       | Security – confidentiality             | Provide ability for allowed users to view confidential data |
| PD.NFXNREQ.004       | Security – confidentiality             | Anonymize data that is exported from the system |
| PD.NFXNREQ.005       | Security – confidentiality             | Prevent remembering username and password |
| PD.NFXNREQ.006       | Security – confidentiality             | Automatically log out the user after specified time of inactivity |
| PD.NFXNREQ.007       | Security – confidentiality             | Provide encrypted communication between components |
| PD.NFXNREQ.008       | Security – authentication              | Notify the user to change their password the first time they log in |
| PD.NFXNREQ.009       | Security – authentication              | Adhere to complex password requirements |
| PD.NFXNREQ.010       | Security – authentication              | Provide a mechanism to securely change a user's password |
| PD.NFXNREQ.011       | Security – authentication              | Notify the user of password change to their account |
| PD.NFXNREQ.012       | Security – authentication              | Reset a user's password in a secure manner |
| PD.NFXNREQ.013       | Security – authentication              | Lock a user out after a specified number of wrong password attempts |
| PD.NFXNREQ.014       | Security – authentication              | Notify a user if their account is locked due to wrong password attempts |
| PD.NFXNREQ.015       | Security – authentication              | Provide role-based access to the system |
| PD.NFXNREQ.016       | Security – audit trail and logs        | Log system logins and logouts |
| PD.NFXNREQ.017       | Security – audit trail and logs        | Record all authentication violations |
| PD.NFXNREQ.018       | Security – audit trail and logs        | Log all activities performed by the user, including date-and-time stamp |
| PD.NFXNREQ.019       | Security – audit trail and logs        | Log access to views of individual client records |
| PD.NFXNREQ.020       | Security – audit trail and logs        | Log access to data summaries, reports, analysis and visualization features |
| PD.NFXNREQ.021       | Security – audit trail and logs        | Log exchange of data with other systems |
| PD.NFXNREQ.022       | Security – audit trail and logs        | Generate analysis of the usage of different system features and reports |
| PD.NFXNREQ.023       | Security – audit trail and logs        | Log all data and system errors |
| PD.NFXNREQ.024       | Security – user management             | Allow user with permission to create a new user and temporary password |
| PD.NFXNREQ.025       | Security – user management             | Provide role-based access |
| PD.NFXNREQ.026       | Security – user management             | Allow roles to be associated with specific geographical areas and/or healthcare facilities |
| PD.NFXNREQ.027       | Security – user management             | Allow cascading user management and assignment of roles |
| PD.NFXNREQ.028       | Security – user management             | Allow user to change their own password |
| PD.NFXNREQ.029       | Security – user management             | Allow admin user to request password reset |
| PD.NFXNREQ.030       | Security – user management             | Notify the user to regularly change their password |
| PD.NFXNREQ.031       | Security – user management             | Allow each user to be assigned to one or more roles |
| PD.NFXNREQ.032       | Security – user management             | Support definitions of unlimited roles and assigned levels of access, viewing, entry, editing and auditing |
| PD.NFXNREQ.033       | System requirements – general          | Provide a unique version number for each revision |
| PD.NFXNREQ.034       | System requirements – general          | Enable earlier versions of a record to be recoverable |
| PD.NFXNREQ.035       | System requirements – general          | Enable deployment in an environment subject to power loss |
| PD.NFXNREQ.036       | System requirements – general          | Work in an environment that is subject to loss of connectivity |
| PD.NFXNREQ.037       | System requirements – general          | Generate IDs that are unique across different installations or sites |
| PD.NFXNREQ.038       | System requirements – general          | Report version number when saving data to the database |
| PD.NFXNREQ.039       | System requirements – general          | Be designed to be flexible enough to accommodate necessary changes in the future |
| PD.NFXNREQ.040       | System requirements – general          | Allow for offline and online functionality |
| PD.NFXNREQ.041       | System requirements – general          | Show the number of records that are not yet synchronized |
| PD.NFXNREQ.042       | System requirements – general          | Have ability to easily back up information |
| PD.NFXNREQ.043       | System requirements – general          | Warn user if no valid backup for more than a predefined number of days |
| PD.NFXNREQ.044       | System requirements – general          | Must have the ability to store images and other unstructured data |
| PD.NFXNREQ.045       | System requirements – scalability      | Scalable to accommodate new demands |
| PD.NFXNREQ.046       | System requirements – scalability      | Be able to accommodate at least [x number of] healthcare facilities |
| PD.NFXNREQ.047       | System requirements – scalability      | Be able to accommodate at least [x number of] concurrent users |
| PD.NFXNREQ.048       | System requirements – usability        | Be user-friendly for people with low computer literacy |
| PD.NFXNREQ.049       | System requirements – usability        | Provide informative error messages and tooltips |
| PD.NFXNREQ.050       | System requirements – usability        | Alert the user when navigating away from a form without saving |
| PD.NFXNREQ.051       | System requirements – usability        | Support real-time data-entry validation and feedback |
| PD.NFXNREQ.052       | System requirements – usability        | Simplify data entry through dropdowns, radio buttons, checkboxes |
| PD.NFXNREQ.053       | System requirements – usability        | Support multiple languages |
| PD.NFXNREQ.054       | System requirements – usability        | Use industry standard UI practices consistently |
| PD.NFXNREQ.055       | System requirements – usability        | Easy to learn and navigate interface |
| PD.NFXNREQ.056       | System requirements – usability        | Provide guidance to support clinical guidelines and practices |
| PD.NFXNREQ.057       | System requirements – usability        | Be reliable and robust (minimize system crashes) |
| PD.NFXNREQ.058       | System requirements – usability        | Adjust display to fit small screens (e.g., mobile phones) |
| PD.NFXNREQ.059       | System requirements – configuration    | Configure the system centrally |
| PD.NFXNREQ.060       | System requirements – configuration    | Configure business rules to match guidelines and SOPs |
| PD.NFXNREQ.061       | System requirements – configuration    | Configure error messages |
| PD.NFXNREQ.062       | System requirements – configuration    | Configure workflows to accommodate facility differences |
| PD.NFXNREQ.063       | System requirements – interoperability | Communicate with external systems through mediators |
| PD.NFXNREQ.064       | System requirements – interoperability | Provide access to data via APIs |
| PD.NFXNREQ.065       | System requirements – interoperability | Be interoperable with external systems through mediators |
| PD.NFXNREQ.066       | System requirements – interoperability | Link with insurance systems to verify eligibility and submit claims |
| PD.NFXNREQ.067       | System requirements – interoperability | Exchange data with other approved systems |
| PD.NFXNREQ.068       | System requirements – interoperability | Accept data from multiple input methods, including GPS |
| PD.NFXNREQ.069       | System requirements – hardware/connectivity | Allow for data exchange and sync across facilities, even with intermittent internet |
