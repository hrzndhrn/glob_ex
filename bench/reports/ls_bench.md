Benchmark GlobEx.ls/1

Comparing `GlobEx.ls/1` with `Path.wildcard/2`.


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
    <td style="white-space: nowrap">1.15.6</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">26.1.1</td>
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



__Input: {lib,test}/**/*.{ex,exs}__

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
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap; text-align: right">247.83</td>
    <td style="white-space: nowrap; text-align: right">4.04 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;15.36%</td>
    <td style="white-space: nowrap; text-align: right">4.00 ms</td>
    <td style="white-space: nowrap; text-align: right">5.47 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">246.51</td>
    <td style="white-space: nowrap; text-align: right">4.06 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;15.11%</td>
    <td style="white-space: nowrap; text-align: right">4.02 ms</td>
    <td style="white-space: nowrap; text-align: right">5.51 ms</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap;text-align: right">247.83</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">246.51</td>
    <td style="white-space: nowrap; text-align: right">1.01x</td>
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
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap">492.13 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">572.67 KB</td>
    <td>1.16x</td>
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
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap">41.93 K</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">64.89 K</td>
    <td>1.55x</td>
  </tr>
</table>