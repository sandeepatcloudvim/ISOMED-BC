table 50026 "CBR Tenant Media Set1"
{
    Caption = 'Tenant Media Set';
    DataPerCompany = false;

    fields
    {
        field(1; ID; Guid)
        {
            Caption = 'ID';
        }
        field(2; "Media ID"; Media)
        {
            Caption = 'Media ID';
        }
        field(3; "Company Name"; Text[30])
        {
            Caption = 'Company Name';
            TableRelation = Company.Name;
        }
    }

    keys
    {
        key(Key1; ID, "Media ID")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

