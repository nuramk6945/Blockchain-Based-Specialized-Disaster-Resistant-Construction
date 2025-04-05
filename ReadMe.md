# Blockchain-Based Disaster-Resistant Construction

This project implements a blockchain-based system for registering, verifying, and certifying disaster-resistant construction using Clarity smart contracts on the Stacks blockchain.

## Overview

The system consists of four main smart contracts:

1. **Building Registration Contract**: Records details of structures in hazard-prone areas
2. **Material Verification Contract**: Validates appropriate building components
3. **Construction Technique Contract**: Ensures proper implementation of safety features
4. **Certification Contract**: Issues verification of disaster-resistant standards

## Smart Contracts

### Building Registration Contract

The Building Registration Contract allows property owners to register their buildings with details such as location, construction date, square footage, and the type of hazard zone. Each building is assigned a unique ID, and the contract maintains a relationship between buildings and their owners.

Key functions:
- `register-building`: Register a new building
- `get-building`: Retrieve building details
- `get-buildings-by-owner`: Get all buildings owned by a specific address
- `update-building-status`: Update the status of a building (e.g., "registered", "under construction", "completed")

### Material Verification Contract

The Material Verification Contract manages the registration and verification of building materials used in disaster-resistant construction. It tracks details such as material name, type, resistance rating, and manufacturer.

Key functions:
- `register-material`: Register a new material
- `verify-material`: Verify a material meets disaster resistance standards
- `add-materials-to-building`: Associate materials with a specific building
- `are-building-materials-verified`: Check if all materials for a building are verified

### Construction Technique Contract

The Construction Technique Contract ensures that proper construction techniques are implemented for disaster resistance. It tracks techniques, their implementation in buildings, and verification of proper implementation.

Key functions:
- `register-technique`: Register a new construction technique
- `verify-technique`: Verify a technique is effective for disaster resistance
- `add-techniques-to-building`: Associate techniques with a specific building
- `verify-technique-implementation`: Verify a technique was properly implemented in a building
- `are-building-techniques-verified`: Check if all techniques for a building are verified

### Certification Contract

The Certification Contract issues and manages certifications for buildings that meet disaster-resistant standards. Certifications include details such as resistance level, hazard types covered, and expiration date.

Key functions:
- `issue-certification`: Issue a certification for a building
- `revoke-certification`: Revoke a previously issued certification
- `is-certification-valid`: Check if a certification is valid (not expired or revoked)
- `is-certified-for-hazard`: Check if a building is certified for a specific hazard type

## Testing

The project includes comprehensive tests using Vitest. The tests cover all major functionality of the smart contracts.

To run the tests:

```bash
npm test
