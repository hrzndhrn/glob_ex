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
    <td style="white-space: nowrap">1.17.0-rc.0</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">27.0</td>
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
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap; text-align: right">79.03</td>
    <td style="white-space: nowrap; text-align: right">12.65 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;10.75%</td>
    <td style="white-space: nowrap; text-align: right">12.53 ms</td>
    <td style="white-space: nowrap; text-align: right">14.21 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap; text-align: right">62.60</td>
    <td style="white-space: nowrap; text-align: right">15.97 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;31.26%</td>
    <td style="white-space: nowrap; text-align: right">12.67 ms</td>
    <td style="white-space: nowrap; text-align: right">22.93 ms</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap;text-align: right">79.03</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap; text-align: right">62.60</td>
    <td style="white-space: nowrap; text-align: right">1.26x</td>
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
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap">4.27 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap">4.26 MB</td>
    <td>1.0x</td>
  </tr>
</table>



Reduction Count

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">Average</th>
    <th style="text-align: right">Factor</th>
  </tr>
  <tr>
    <td style="white-space: nowrap">glob_string</td>
    <td style="white-space: nowrap">374.08 K</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">compiled_glob</td>
    <td style="white-space: nowrap">380.01 K</td>
    <td>1.02x</td>
  </tr>
</table>