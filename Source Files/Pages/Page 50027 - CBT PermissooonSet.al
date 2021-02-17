page 50027 "Permissooon Set"
{
    PageType = List;
    SourceTable = "Permission Set";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Role ID"; "Role ID")
                {
                    ApplicationArea = All;
                }
                field(Name; Name)
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

