function [out_C, ierr] = cg_coord_partial_write(in_fn, in_B, in_Z, in_type, in_coordname, in_rmin, in_rmax, in_coord_ptr)
% Gateway function for C function cg_coord_partial_write.
%
% [C, ierr] = cg_coord_partial_write(fn, B, Z, type, coordname, rmin, rmax, coord_ptr)
%
% Input arguments (required; type is auto-casted):
%              fn: 32-bit integer (int32), scalar
%               B: 32-bit integer (int32), scalar
%               Z: 32-bit integer (int32), scalar
%            type: 32-bit integer (int32), scalar
%       coordname: character string
%            rmin: 64-bit or 32-bit integer (platform dependent), array
%            rmax: 64-bit or 32-bit integer (platform dependent), array
%       coord_ptr: dynamic type based on type
%
% Output arguments (optional):
%               C: 32-bit integer (int32), scalar
%            ierr: 32-bit integer (int32), scalar
%
% The original C function is:
% int cg_coord_partial_write( int fn, int B, int Z, CG_DataType_t type, const char * coordname, const ptrdiff_t * rmin, const ptrdiff_t * rmax, const void * coord_ptr, int * C);
%
% For detail, see <a href="http://www.grc.nasa.gov/WWW/cgns/CGNS_docs_current/midlevel/grid.html">online documentation</a>.
%
if (nargin < 8); 
    error('Incorrect number of input or output arguments.');
end

% Perform dynamic type casting
datatype = in_type;
switch (datatype)
    case 2 % CG_Integer
        in_coord_ptr = int32(in_coord_ptr);
    case 3 % CG_RealSingle
        in_coord_ptr = single(in_coord_ptr);
    case 4 % CG_RealDouble
        in_coord_ptr = double(in_coord_ptr);
    case 5 % CG_Character
        in_coord_ptr = [int8(in_coord_ptr), int8(zeros(1,1))];
    case 6 % CG_LongInteger
        in_coord_ptr = int64(in_coord_ptr);
    otherwise
        error('Unknown data type %d', in_type);
end


% Invoke the actual MEX-function.
[out_C, ierr] =  cgnslib_mex(int32(70), in_fn, in_B, in_Z, in_type, in_coordname, in_rmin, in_rmax, in_coord_ptr);
