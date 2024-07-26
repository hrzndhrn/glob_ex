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
    <td style="white-space: nowrap">1.17.2</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">27.0.1</td>
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
    <td style="white-space: nowrap; text-align: right">79.13</td>
    <td style="white-space: nowrap; text-align: right">12.64 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;3.52%</td>
    <td style="white-space: nowrap; text-align: right">12.56 ms</td>
    <td style="white-space: nowrap; text-align: right">14.49 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">75.37</td>
    <td style="white-space: nowrap; text-align: right">13.27 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2.75%</td>
    <td style="white-space: nowrap; text-align: right">13.15 ms</td>
    <td style="white-space: nowrap; text-align: right">14.47 ms</td>
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
    <td style="white-space: nowrap;text-align: right">79.13</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">75.37</td>
    <td style="white-space: nowrap; text-align: right">1.05x</td>
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
    <td style="white-space: nowrap">4.27 MB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">5.18 MB</td>
    <td>1.21x</td>
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
    <td style="white-space: nowrap">374.07 K</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">615.33 K</td>
    <td>1.64x</td>
  </tr>
</table>