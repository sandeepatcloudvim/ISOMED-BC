tableextension 50009 CBRExtendContact extends Contact
{
    fields
    {
        // Add changes to table fields here
        field(50000; "CBR Lead Type"; Text[30])
        {
            Caption = 'Lead Type';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }


    procedure CBRUpdateLeadType(ContactNo: Code[20])
    var
        ContactBusRelation: Record "Contact Business Relation";
        contact: Record Contact;
    begin
        Contact.RESET;
        IF ContactNo <> '' THEN
            Contact.SETRANGE("No.", ContactNo);
        IF Contact.FIND('-') THEN
            REPEAT
                ContactBusRelation.RESET;
                ContactBusRelation.SETRANGE("Contact No.", Contact."Company No.");
                IF ContactBusRelation.FINDFIRST THEN BEGIN
                    ContactBusRelation.CALCFIELDS("Business Relation Description");
                    Contact."CBR Lead Type" := ContactBusRelation."Business Relation Description";
                END ELSE
                    Contact."CBR Lead Type" := 'Lead';
                Contact.MODIFY;
            UNTIL Contact.NEXT = 0;
    end;

    var
        ContactBusRelation: Record "Contact Business Relation";
}