# trading_portfolio_app

Flutter application that displays a list of trading instruments of a user along with a real-time
price from a simulation.

## Details

- App uses **CLEAN** with *layered architecture* for better maintainability and scalability.
- Unit tested & widget tested.
- App uses state management using bloc for better presentation isolation and management.

### Highlights

- Include golden tests
- Design system for tokens and components
- Ensures type safety by enabling additional type [checks](https://dart.dev/language/type-system)

```yaml
    strict-casts: true
    strict-inference: true
    strict-raw-types: true
```

### Technical details

- Provider for DI to follow inherited widget hierarchy
- BloC for state management
-

### Code quality

- 97.2% coverage
    - Unit tests -> 80%
    - Widget tests -> 10%
    - Golden tests -> 5%

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
   |--desisgn
        |--design_system
```

### Environment

```
  flutter: '3.24.5'
  dart: '3.5.4'
```