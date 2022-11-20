Benchmark GlobEx.ls/1 with compiled glob

Comparing compiled glob with a glob string.


## System

Benchmark suite executing on the following system:

<table style="width: 1%">
  <tr>
    <th style="width: 1%; white-space: nowrap">Operating System</th>
    <td>macOS</td>
  </tr><tr>
    <th style="white-space: nowrap">CPU Information</th>
    <td style="white-space: nowrap">Apple M1</td>
  </tr><tr>
    <th style="white-space: nowrap">Number of Available Cores</th>
    <td style="white-space: nowrap">8</td>
  </tr><tr>
    <th style="white-space: nowrap">Available Memory</th>
    <td style="white-space: nowrap">16 GB</td>
  </tr><tr>
    <th style="white-space: nowrap">Elixir Version</th>
    <td style="white-space: nowrap">1.14.1</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">25.1.2</td>
  </tr>
</table>

## Configuration

Benchmark suite executing with the following configuration:

<table style="width: 1%">
  <tr>
    <th style="width: 1%">:time</th>
    <td style="white-space: nowrap">10 s</td>
  </tr><tr>
    <th>:parallel</th>
    <td style="white-space: nowrap">1</td>
  </tr><tr>
    <th>:warmup</th>
    <td style="white-space: nowrap">2 s</td>
  </tr>
</table>

## Statistics



Run Time

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Devitation</th>
    <th style="text-align: right">Median</th>
    <th style="text-align: right">99th&nbsp;%</th>
  </tr>

  <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap; text-align: right">189.92 K</td>
    <td style="white-space: nowrap; text-align: right">5.27 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;441.68%</td>
    <td style="white-space: nowrap; text-align: right">2.83 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">24.98 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap; text-align: right">178.54 K</td>
    <td style="white-space: nowrap; text-align: right">5.60 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;301.20%</td>
    <td style="white-space: nowrap; text-align: right">3.04 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">25.96 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap;text-align: right">189.92 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap; text-align: right">178.54 K</td>
    <td style="white-space: nowrap; text-align: right">1.06x</td>
  </tr>

</table>



Memory Usage

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap">0.40 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap">1.23 KB</td>
    <td>3.08x</td>
  </tr>
</table>