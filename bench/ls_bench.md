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



__Input: **/enum*__

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
    <td style="white-space: nowrap; text-align: right">274.52</td>
    <td style="white-space: nowrap; text-align: right">3.64 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;24.95%</td>
    <td style="white-space: nowrap; text-align: right">3.72 ms</td>
    <td style="white-space: nowrap; text-align: right">5.46 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">273.11</td>
    <td style="white-space: nowrap; text-align: right">3.66 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;18.43%</td>
    <td style="white-space: nowrap; text-align: right">3.64 ms</td>
    <td style="white-space: nowrap; text-align: right">5.24 ms</td>
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
    <td style="white-space: nowrap;text-align: right">274.52</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">273.11</td>
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
    <td style="white-space: nowrap">316.23 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">511.40 KB</td>
    <td>1.62x</td>
  </tr>
</table>



__Input: **/enum.ex__

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
    <td style="white-space: nowrap; text-align: right">277.23</td>
    <td style="white-space: nowrap; text-align: right">3.61 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;23.99%</td>
    <td style="white-space: nowrap; text-align: right">3.67 ms</td>
    <td style="white-space: nowrap; text-align: right">5.42 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">271.01</td>
    <td style="white-space: nowrap; text-align: right">3.69 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;19.39%</td>
    <td style="white-space: nowrap; text-align: right">3.65 ms</td>
    <td style="white-space: nowrap; text-align: right">5.37 ms</td>
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
    <td style="white-space: nowrap;text-align: right">277.23</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">271.01</td>
    <td style="white-space: nowrap; text-align: right">1.02x</td>
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
    <td style="white-space: nowrap">326.59 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">509.73 KB</td>
    <td>1.56x</td>
  </tr>
</table>



__Input: mix.exs__

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
    <td style="white-space: nowrap; text-align: right">179.70 K</td>
    <td style="white-space: nowrap; text-align: right">5.56 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;221.81%</td>
    <td style="white-space: nowrap; text-align: right">3 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">31.71 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">122.26 K</td>
    <td style="white-space: nowrap; text-align: right">8.18 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;193.90%</td>
    <td style="white-space: nowrap; text-align: right">6.08 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">38.29 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">179.70 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">122.26 K</td>
    <td style="white-space: nowrap; text-align: right">1.47x</td>
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
    <td style="white-space: nowrap">1.23 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">2.11 KB</td>
    <td>1.72x</td>
  </tr>
</table>



__Input: {lib,test}/**/*.java__

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
    <td style="white-space: nowrap; text-align: right">274.87</td>
    <td style="white-space: nowrap; text-align: right">3.64 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;23.93%</td>
    <td style="white-space: nowrap; text-align: right">3.72 ms</td>
    <td style="white-space: nowrap; text-align: right">5.35 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">265.72</td>
    <td style="white-space: nowrap; text-align: right">3.76 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;18.44%</td>
    <td style="white-space: nowrap; text-align: right">3.72 ms</td>
    <td style="white-space: nowrap; text-align: right">5.45 ms</td>
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
    <td style="white-space: nowrap;text-align: right">274.87</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">265.72</td>
    <td style="white-space: nowrap; text-align: right">1.03x</td>
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
    <td style="white-space: nowrap">390.42 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">512.29 KB</td>
    <td>1.31x</td>
  </tr>
</table>



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
    <td style="white-space: nowrap; text-align: right">250.80</td>
    <td style="white-space: nowrap; text-align: right">3.99 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;19.51%</td>
    <td style="white-space: nowrap; text-align: right">4.03 ms</td>
    <td style="white-space: nowrap; text-align: right">5.66 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">248.04</td>
    <td style="white-space: nowrap; text-align: right">4.03 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;17.34%</td>
    <td style="white-space: nowrap; text-align: right">4.03 ms</td>
    <td style="white-space: nowrap; text-align: right">5.62 ms</td>
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
    <td style="white-space: nowrap;text-align: right">250.80</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">248.04</td>
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
    <td style="white-space: nowrap">478.94 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">583.53 KB</td>
    <td>1.22x</td>
  </tr>
</table>