procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
var
  HTML: TStringBuilder;
begin
  HTML := TStringBuilder.Create;
  try
    // Формируем заголовок HTML страницы
    HTML.Append('<html><head><title>Список товаров</title>');
    HTML.Append('<meta charset="utf-8">');
    HTML.Append('<style>table {border-collapse: collapse; width: 50%;} th, td {border: 1px solid #ddd; padding: 8px;} th {background-color: #f2f2f2;}</style>');
    HTML.Append('</head><body>');
    HTML.Append('<h1>Каталог товаров (WebBroker + IIS)</h1>');
    HTML.Append('<table>');
    HTML.Append('<tr><th>ID</th><th>Название</th><th>Категория</th><th>Цена</th></tr>');

    try
      // Открываем соединение и запрос
      FDQuery1.Open;
      
      // Проходим по всем записям
      while not FDQuery1.Eof do
      begin
        HTML.Append('<tr>');
        HTML.AppendFormat('<td>%d</td>', [FDQuery1.FieldByName('ID').AsInteger]);
        HTML.AppendFormat('<td>%s</td>', [FDQuery1.FieldByName('ProductName').AsString]);
        HTML.AppendFormat('<td>%s</td>', [FDQuery1.FieldByName('Category').AsString]);
        HTML.AppendFormat('<td>%.2f руб.</td>', [FDQuery1.FieldByName('Price').AsFloat]);
        HTML.Append('</tr>');
        
        FDQuery1.Next;
      end;
    except
      on E: Exception do
        HTML.Append('<p style="color:red">Ошибка БД: ' + E.Message + '</p>');
    end;

    HTML.Append('</table>');
    HTML.Append('<p>Сгенерировано в Delphi 10.2</p>');
    HTML.Append('</body></html>');

    // Отправляем ответ браузеру
    Response.Content := HTML.ToString;
  finally
    HTML.Free;
    // Закрываем соединение, чтобы не держать пул
    FDQuery1.Close;
  end;
end;