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
    <td style="white-space: nowrap; text-align: right">260.40</td>
    <td style="white-space: nowrap; text-align: right">3.84 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;29.57%</td>
    <td style="white-space: nowrap; text-align: right">3.84 ms</td>
    <td style="white-space: nowrap; text-align: right">7.12 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">260.10</td>
    <td style="white-space: nowrap; text-align: right">3.84 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;21.91%</td>
    <td style="white-space: nowrap; text-align: right">3.81 ms</td>
    <td style="white-space: nowrap; text-align: right">6.04 ms</td>
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
    <td style="white-space: nowrap;text-align: right">260.40</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">260.10</td>
    <td style="white-space: nowrap; text-align: right">1.0x</td>
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
    <td style="white-space: nowrap; text-align: right">272.74</td>
    <td style="white-space: nowrap; text-align: right">3.67 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;29.70%</td>
    <td style="white-space: nowrap; text-align: right">3.74 ms</td>
    <td style="white-space: nowrap; text-align: right">5.76 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">266.51</td>
    <td style="white-space: nowrap; text-align: right">3.75 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;20.59%</td>
    <td style="white-space: nowrap; text-align: right">3.74 ms</td>
    <td style="white-space: nowrap; text-align: right">5.64 ms</td>
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
    <td style="white-space: nowrap;text-align: right">272.74</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">266.51</td>
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
    <td style="white-space: nowrap; text-align: right">168.26 K</td>
    <td style="white-space: nowrap; text-align: right">5.94 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;265.19%</td>
    <td style="white-space: nowrap; text-align: right">5.50 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">27.04 &micro;s</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">115.47 K</td>
    <td style="white-space: nowrap; text-align: right">8.66 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;162.61%</td>
    <td style="white-space: nowrap; text-align: right">6.21 &micro;s</td>
    <td style="white-space: nowrap; text-align: right">44.12 &micro;s</td>
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
    <td style="white-space: nowrap;text-align: right">168.26 K</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">115.47 K</td>
    <td style="white-space: nowrap; text-align: right">1.46x</td>
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
    <td style="white-space: nowrap; text-align: right">265.22</td>
    <td style="white-space: nowrap; text-align: right">3.77 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;26.95%</td>
    <td style="white-space: nowrap; text-align: right">3.83 ms</td>
    <td style="white-space: nowrap; text-align: right">5.82 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">264.39</td>
    <td style="white-space: nowrap; text-align: right">3.78 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;22.00%</td>
    <td style="white-space: nowrap; text-align: right">3.75 ms</td>
    <td style="white-space: nowrap; text-align: right">5.56 ms</td>
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
    <td style="white-space: nowrap;text-align: right">265.22</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">264.39</td>
    <td style="white-space: nowrap; text-align: right">1.0x</td>
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
    <td style="white-space: nowrap; text-align: right">244.38</td>
    <td style="white-space: nowrap; text-align: right">4.09 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;23.37%</td>
    <td style="white-space: nowrap; text-align: right">4.13 ms</td>
    <td style="white-space: nowrap; text-align: right">6.54 ms</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">237.05</td>
    <td style="white-space: nowrap; text-align: right">4.22 ms</td>
    <td style="white-space: nowrap; text-align: right">&plusmn;20.70%</td>
    <td style="white-space: nowrap; text-align: right">4.15 ms</td>
    <td style="white-space: nowrap; text-align: right">6.60 ms</td>
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
    <td style="white-space: nowrap;text-align: right">244.38</td>
    <td>&nbsp;</td>
  </tr>

  <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap; text-align: right">237.05</td>
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
    <td style="white-space: nowrap">478.94 KB</td>
    <td>&nbsp;</td>
  </tr>
    <tr>
    <td style="white-space: nowrap">Path.wildcard/2</td>
    <td style="white-space: nowrap">583.53 KB</td>
    <td>1.22x</td>
  </tr>
</table>