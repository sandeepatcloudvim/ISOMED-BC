table 50027 "CBR Copy Item Desc"
{

    fields
    {
        field(1; "Entry No"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Table ID"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "RecordID Value"; RecordID)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Document Type"; Option)
        {
            Caption = 'Document Type';
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = " ",Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(5; "Document No"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(6; LineNo; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(7; "Rec EntryNo"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Org. Item Description"; Text[200])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Item No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }

    keys
    {
        key(Key1; "Entry No")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
    }
}

