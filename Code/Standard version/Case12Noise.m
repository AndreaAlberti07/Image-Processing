%Select the type of noise to be deleted
noise_type=input('Insert the number of noise you prefer: \n1 - Gaussian \n2 - Salt & pepper \n - Your choice --> ');

if noise_type==1 %if gaussian
    DenoiseGaussian(img);
else %if salt and pepper
    DenoiseSP(img);
end

uiwait()