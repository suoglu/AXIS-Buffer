# AXIS Buffer

## Contents of Readme

1. About
2. IP Description
3. Interface Description
4. Utilization
5. Status Information
6. Licence

[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-6C488A.svg)](https://gitlab.com/suoglu/axis-buffer)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-3D76C2.svg)](https://github.com/suoglu/AXIS-Buffer)

---

## About

AXIS buffer to keep data until next stage accepts it. Does not add any latency.

## IP Description

This IP can be placed in between a master and a slave to allow master to drop packages without breaking AXIS protocol. IP itself does not add any latency.

Initially IP is in pass state, which directly forwards slave interface to master interface and updates registers with the content. If master interface is not ready when slave interface is valid; values stored in the registers are kept and forwarded to master interface until the handshake. Value of the ready signal for the slave interface can be selected by the parameter `SLAVE_ALWAYS_READY`.

Strobe and last signals, as well as some debug/statistic ports can be enabled and disabled via parameters.

## Interface Description

### Ports

|   Port   | Type | Width | Optional | Description |
| :------: | :----: | :----: | :----: | ------  |
| `axis_aclk` | I | 1 | No | AXIS Clock |
| `axis_aresetn` | I | 1 | No | AXIS Reset |
| `buffering` | O | 1 | Yes | IP Currently buffering a transmission |
| `dropped` | O | `DROP_COUNTER_WIDTH` | Yes | Dropped Counter |
| `dropped_reset` | I | 1 | Yes | Dropped Counter Reset |
| `s00_axis_tvalid` | I | 1 | No | Slave Interface Valid |
| `s00_axis_tready` | O | 1 | No | Slave Interface Ready |
| `s00_axis_tlast` | I | 1 | Yes | Slave Interface Last |
| `s00_axis_tdata` | I | `C_S00_AXIS_TDATA_WIDTH` | No | Slave Interface Data|
| `s00_axis_tstrb` | I | `C_S00_AXIS_TDATA_WIDTH`/8 | Yes | Slave Interface Strobe|
| `m00_axis_tvalid` | O | 1 | No | Master Interface Valid |
| `m00_axis_tready` | I | 1 | No | Master Interface Ready |
| `m00_axis_tlast` | O | 1 | Yes | Master Interface Last |
| `m00_axis_tdata` | O | `C_M00_AXIS_TDATA_WIDTH` | No | Master Interface Data |
| `m00_axis_tstrb` | O | `C_M00_AXIS_TDATA_WIDTH`/8 | Yes | Master Interface Strobe |

I: Input  O: Output

### Parameters

| Parameter | Purpose |
| :---: | --- |
|`BUFFERING_O_EN`| Enables `buffering` pin |
|`TLAST_EN`| Enables last signal for AXIS interfaces|
|`TSTRB_EN`| Enables strobe signal for AXIS interfaces|
|`DROP_COUNTER_EN`| Enables drop counter; `dropped` and `dropped_reset` |
|`DROP_COUNTER_WIDTH`| Width of `dropped` |
|`SLAVE_ALWAYS_READY`| Slave interface always ready instead of when not buffering|
|`C_S00_AXIS_TDATA_WIDTH`|Width of data bus for AXIS Slave Interface|
|`C_M00_AXIS_TDATA_WIDTH`|Width of data bus for AXIS Master Interface|

## Utilization

### Only Mandatory Ports Enabled

**(Synthesized) Utilization with 16 byte buffer on Artix-7:**

* Slice LUTs as Logic: 18
* Slice Registers as Flip Flop: 33

### All Ports Enabled

**(Synthesized) Utilization with 16 byte buffer on Artix-7:**

* Slice LUTs as Logic: 23
* Slice Registers as Flip Flop: 70

## Status Information

**Last Simulation:** 19 March 2022, with [Icarus Verilog](https://iverilog.icarus.com/).

## Licence

CERN Open Hardware Licence Version 2 - Weakly Reciprocal
