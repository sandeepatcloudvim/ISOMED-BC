report 50024 "Import Images1"
{
    ProcessingOnly = true;

    dataset
    {
        dataitem(Item; Item)
        {
            DataItemTableView = SORTING ("No.");

            trigger OnAfterGetRecord()
            begin
                Clear(SourceItm);
                Clear(TenantMediaSet);
                Clear(TenantMedia);
                if SourceItm.Get(Item."No.") then begin
                    for I := 1 to SourceItm.Picture.Count do begin
                        TargetItm.ChangeCompany('CRONUS Canada, Inc.');
                        if TargetItm.Get(SourceItm."No.") then begin
                            TargetItm.Picture.Insert(SourceItm.Picture.Item(I));
                            TargetItm.Modify(true);
                            if TenantMedia.Get(SourceItm.Picture.Item(I)) then begin
                                TenantMedia."Company Name" := '';
                                TenantMedia.Modify;
                            end;
                            if TenantMediaSet.Get(TargetItm.Picture.MediaId, SourceItm.Picture.Item(I)) then begin
                                TenantMediaSet."Company Name" := '';
                                TenantMediaSet.Modify;
                            end;
                        end;
                    end;
                end;




                // IF SourceItm.GET(Item."No.") THEN BEGIN
                // FOR I := 1 TO SourceItm.Picture.COUNT DO BEGIN
                //  //SourceItm.CALCFIELDS(Picture);
                //  TargetItm.CHANGECOMPANY('CRONUS Canada, Inc.');
                //  IF TargetItm.GET(SourceItm."No.") THEN BEGIN
                //    TargetItm.Picture.INSERT(SourceItm.Picture.ITEM(I));
                //    TargetItm.MODIFY(TRUE);
                //    END;
                // END;
                // END;
            end;

            trigger OnPostDataItem()
            begin
                Message('Finished');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        SourceItm: Record Item;
        TargetItm: Record Item;
        TenantMediaSet: Record "Tenant Media Set";
        TenantMedia: Record "Tenant Media";
        I: Integer;
}

