page 50054 "Item Description"
{
    PageType = List;
    SourceTable = "CBR Copy Item Desc";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Entry No"; "Entry No")
                {
                    ApplicationArea = All;
                }
                field("Table ID"; "Table ID")
                {
                    ApplicationArea = All;
                }
                field("RecordID Value"; "RecordID Value")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No"; "Document No")
                {
                    ApplicationArea = All;
                }
                field(LineNo; LineNo)
                {
                    ApplicationArea = All;
                }
                field("Rec EntryNo"; "Rec EntryNo")
                {
                    ApplicationArea = All;
                }
                field("Org. Item Description"; "Org. Item Description")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

