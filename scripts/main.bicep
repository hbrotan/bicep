resource plan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'plan-fagkveld'
  location: resourceGroup().location
  properties: {
    reserved: true
  }
  kind: 'linux'
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
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
    serverFarmId: plan.id
    siteConfig: {
      linuxFxVersion: 'DOTNETCORE|6.0'
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appi.properties.InstrumentationKey
        }
      ]
    }
  }
}
