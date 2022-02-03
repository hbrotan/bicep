// Already in the context of a resource group


resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-fagkveld'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    tier: 'Free'
  }
  kind: 'linux'
}

resource appi 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-fagkveld'
  location: resourceGroup().location
  kind: 'web'
  properties: {
      Application_Type: 'web'
  }
}

resource app 'Microsoft.Web/sites@2021-02-01' = {
  name: 'app-fagkveld'
  location: resourceGroup().location
  properties: {
    siteConfig: {
        appSettings: [
            { 
                name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
                value: appi.properties.InstrumentationKey
            }           
        ]
    }
    serverFarmId: plan.id
  }  
}