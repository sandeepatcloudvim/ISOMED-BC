table 50020 "CBR Item Based HTML Codes"
{

    fields
    {
        field(1; "Item No."; Code[20])
        {
            TableRelation = Item."No.";
        }
        field(2; "Line No."; Integer)
        {
        }
        field(3; "HTML Line Code"; Text[250])
        {
        }
    }

    keys
    {
        key(Key1; "Item No.", "Line No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

