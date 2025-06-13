# trading_portfolio_app

Flutter application that displays a list of trading instruments of a user along with a real-time price from a simulation.

## Getting Started

- App uses **CLEAN** with *layered architecture* for better maintainability and scalability.
- App's domain logics are unit tested & widget tested.
- App uses state management using bloc for better presentation isolation and management.

### Highlights

- Include golden tests
- Ensures type safety by enabling additional type [checks](https://dart.dev/language/type-system)
```yaml
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

### Code organization

```
--lib
   |--src
       |--data
       		|--datasource
       |--di
            |--provider
       |--domain
       		|--usecase
       |--presentation
       		|--trades-list
				
--packages
   |--core
   		|--api_client    
```

### Environment

```
  flutter: '3.24.5'
  dart: '3.5.4'
```