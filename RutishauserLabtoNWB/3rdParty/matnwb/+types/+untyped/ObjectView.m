classdef ObjectView < handle
    properties(SetAccess=private)
        path;
    end
    
    properties(Constant, Hidden)
        type = 'H5T_STD_REF_OBJ';
        reftype = 'H5R_OBJECT';
    end
    
    methods
        function obj = ObjectView(path)
            obj.path = path;
        end
        
        function v = refresh(obj, nwb)
            if ~isa(nwb, 'NwbFile')
                error('Argument `nwb` must be a valid `NwbFile`');
            end
            v = nwb.resolve(obj.path);
        end
        
        function refs = export(obj, fid, fullpath, refs)
            io.writeDataset(fid, fullpath, class(obj), obj);
        end
    end
end