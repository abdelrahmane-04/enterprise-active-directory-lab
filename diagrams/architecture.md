# Lab Architecture

```mermaid
flowchart TB
    HOST["Windows Host<br/>Oracle VirtualBox"]
    NET["LAB-AD<br/>Internal Network<br/>192.168.10.0/24"]
    DC["DC01<br/>Windows Server 2025<br/>192.168.10.10<br/>AD DS · DNS · File Shares"]
    CLIENT["CLIENT01<br/>Windows 11 Pro<br/>192.168.10.20<br/>DNS: 192.168.10.10"]
    DOMAIN["enterprise.lab<br/>NetBIOS: ENTREPRISE"]

    subgraph OUS["Active Directory"]
        U["OU=Utilisateurs"]
        IT["OU=Informatique<br/>GRP_Informatique"]
        RH["OU=RH<br/>GRP_RH"]
        DIR["OU=Direction<br/>GRP_Direction"]
        PCS["OU=Ordinateurs<br/>CLIENT01"]
        U --> IT
        U --> RH
        U --> DIR
    end

    GPO1["GPO_Informatique_Restrictions"]
    GPO2["GPO_Ordinateurs_Securite"]
    SH1["\\DC01\Informatique"]
    SH2["\\DC01\RH"]
    SH3["\\DC01\Direction"]

    HOST --> NET
    NET --> DC
    NET --> CLIENT
    DC --> DOMAIN
    DOMAIN --> OUS
    IT --> GPO1
    PCS --> GPO2
    DC --> SH1
    DC --> SH2
    DC --> SH3
    CLIENT -->|Authentication + DNS| DC
```

| Component | Value |
|---|---|
| Domain | `enterprise.lab` |
| NetBIOS | `ENTREPRISE` |
| VirtualBox network | `LAB-AD` |
| Subnet | `192.168.10.0/24` |
| DC01 | `192.168.10.10` |
| CLIENT01 | `192.168.10.20` |
| CLIENT01 DNS | `192.168.10.10` |

The lab uses an isolated VirtualBox internal network with no default gateway.
