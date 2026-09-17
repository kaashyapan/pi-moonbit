# kaashyapan/errors

Put both pi-moonbit && moonbit-docs in the same root folder

```
>> echo $PWD
/Users/moonuser/Code

>> ls
drwxr-xr-x@    - moonuser 17 Sep 11:02 .
drwxr-xr-x@    - moonuser 16 Sep 21:46 ├── moonbit-docs
drwxr-xr-x@    - moonuser 17 Sep 11:44 ├── pi-moonbit
```

```fish
sudo env BASE_LOCATION=/Users/moonuser/Code moon run cmd/main
```

```bash
sudo env BASE_LOCATION=/Users/moonuser/Code moon run cmd/main
```