## Copyright (C) 2017 sai19
## 
## This program is free software; you can redistribute it and/or modify it
## under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 3 of the License, or
## (at your option) any later version.
## 
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
## 
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*- 
## @deftypefn {} {@var{retval} =} altimfuse (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: sai19 <sai19@PRASANNA>
## Created: 2017-11-19

function [retval] = altimfuse (E)
  Comb = E;
  Comb(:,:,1) = (1-I).*E + I; % red
  Comb(:,:,2) = (1-I).*E; % green
  Comb(:,:,3) = (1-I).*E; % blue

figure, imshow(Comb)
endfunction
