# /bin/bash

if (command -v nvm) ; then
  nvm install && nvm use 
fi

npm --prefix control install --no-audit
npm --prefix control audit 

dotnet build ./solution -c Release
