USE cs332e7;

INSERT INTO Professor (Ssn,FirstName,LastName,StreetAdress,City,State,ZipCode,Sex,PhoneArea,PhoneSeven,Title,Salary)
VALUES
  ("423734389","Chanda","Patterson","Ap #475-7284 Non Avenue","Bear","Pennsylvania","86723","F","691","4573131","Associate Professor",59089.33),
  ("860586050","Victor","Whitley","756-3193 Ac Av.","Hilo","Indiana","46662","F","543","0123073","Research Associate",79418.09),
  ("564570095","Peter","Day","Ap #415-1894 Dapibus Av.","Norman","Kansas","27128","F","983","4538895","Professor",160442.57),
  ("282926719","Tanya","Roy","P.O. Box 456, 2829 Risus. Ave","Nampa","Virginia","92935","M","315","9475466","Adjunct Professor",91522.74),
  ("843477602","Sonya","Stevenson","851-1765 Ut Rd.","Huntsville","Maryland","86747","M","684","5272757","Research Associate",144264.93);

  INSERT INTO Department (ChairPerson_Ssn,Name,OfficeLocation,PhoneArea,PhoneSeven)
  VALUES
    ("564570095","Computer Science","Ap #828-7733 Justo Ave","337","1560455"),
    ("423734389","Math","Ap #601-2300 Duis Road","544","0852558");
