function Export_Data(data_to_be_saved, type)
   if strcmp(type, 'Input Arguments') == 0
        save Input_Arguments data_to_be_saved;
   else
        save Additional_Parameters data_to_be_saved
   end
end

