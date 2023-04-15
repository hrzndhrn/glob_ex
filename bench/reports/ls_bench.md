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
    <td style="white-space: nowrap">1.14.4</td>
  </tr><tr>
    <th style="white-space: nowrap">Erlang Version</th>
    <td style="white-space: nowrap">25.3</td>
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
    <td style="white-space: nowrap; text-align: right">286.23</td>
    <td style="white-space: nowrap; text-align: right">3.49 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;22.45%</td>
    <td style="white-space: nowrap; text-align: right">3.52 ms</td>
    <td style="white-space: nowrap; text-align: right">5.19 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">277.73</td>
    <td style="white-space: nowrap; text-align: right">3.60 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;18.91%</td>
    <td style="white-space: nowrap; text-align: right">3.55 ms</td>
    <td style="white-space: nowrap; text-align: right">5.25 ms</td>
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
    <td style="white-space: nowrap;text-align: right">286.23</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">277.73</td>
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
    <td style="white-space: nowrap; text-align: right">288.16</td>
    <td style="white-space: nowrap; text-align: right">3.47 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;23.09%</td>
    <td style="white-space: nowrap; text-align: right">3.49 ms</td>
    <td style="white-space: nowrap; text-align: right">5.21 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">264.69</td>
    <td style="white-space: nowrap; text-align: right">3.78 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;84.48%</td>
    <td style="white-space: nowrap; text-align: right">3.59 ms</td>
    <td style="white-space: nowrap; text-align: right">5.82 ms</td>
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
    <td style="white-space: nowrap;text-align: right">288.16</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">264.69</td>
    <td style="white-space: nowrap; text-align: right">1.09x</td>
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
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">105.51 K</td>
    <td style="white-space: nowrap; text-align: right">9.48 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;135.10%</td>
    <td style="white-space: nowrap; text-align: right">6.33 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">42.46 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap; text-align: right">66.31 K</td>
    <td style="white-space: nowrap; text-align: right">15.08 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;106.29%</td>
    <td style="white-space: nowrap; text-align: right">7.67 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">60.75 &micro;s</td>
  </tr>

</table>


Run Time Comparison

<table style="width: 1%">
  <tr>
    <th>Name</th>
    <th style="text-align: right">IPS</th>
    <th style="text-align: right">Slower</th>
  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap;text-align: right">105.51 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap; text-align: right">66.31 K</td>
    <td style="white-space: nowrap; text-align: right">1.59x</td>
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
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">2.11 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">GlobEx.ls/1</td>
    <td style="white-space: nowrap">1.25 KB</td>
    <td>0.59x</td>
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
    <td style="white-space: nowrap; text-align: right">290.52</td>
    <td style="white-space: nowrap; text-align: right">3.44 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;25.49%</td>
    <td style="white-space: nowrap; text-align: right">3.46 ms</td>
    <td style="white-space: nowrap; text-align: right">5.32 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">95.26</td>
    <td style="white-space: nowrap; text-align: right">10.50 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;2.96%</td>
    <td style="white-space: nowrap; text-align: right">10.48 ms</td>
    <td style="white-space: nowrap; text-align: right">11.58 ms</td>
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
    <td style="white-space: nowrap;text-align: right">290.52</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">95.26</td>
    <td style="white-space: nowrap; text-align: right">3.05x</td>
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
    <td style="white-space: nowrap; text-align: right">264.42</td>
    <td style="white-space: nowrap; text-align: right">3.78 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;30.58%</td>
    <td style="white-space: nowrap; text-align: right">3.78 ms</td>
    <td style="white-space: nowrap; text-align: right">5.53 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">93.95</td>
    <td style="white-space: nowrap; text-align: right">10.64 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;13.74%</td>
    <td style="white-space: nowrap; text-align: right">10.56 ms</td>
    <td style="white-space: nowrap; text-align: right">11.85 ms</td>
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
    <td style="white-space: nowrap;text-align: right">264.42</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">93.95</td>
    <td style="white-space: nowrap; text-align: right">2.81x</td>
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