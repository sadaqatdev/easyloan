package com.homecredit.loan.camera;

import android.Manifest;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;
import android.view.OrientationEventListener;
import android.view.Surface;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.widget.ImageButton;


import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;

import androidx.camera.core.AspectRatio;
import androidx.camera.core.Camera;
import androidx.camera.core.CameraControl;
import androidx.camera.core.CameraInfo;
import androidx.camera.core.CameraSelector;
import androidx.camera.core.FocusMeteringAction;
import androidx.camera.core.FocusMeteringResult;
import androidx.camera.core.ImageAnalysis;
import androidx.camera.core.ImageCapture;
import androidx.camera.core.ImageCaptureException;
import androidx.camera.core.ImageProxy;
import androidx.camera.core.MeteringPoint;
import androidx.camera.core.MeteringPointFactory;
import androidx.camera.core.Preview;
import androidx.camera.core.UseCaseGroup;
import androidx.camera.core.ViewPort;
import androidx.camera.core.ZoomState;
import androidx.camera.lifecycle.ProcessCameraProvider;
import androidx.camera.view.PreviewView;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;
import androidx.lifecycle.LiveData;
import com.homecredit.loan.R;
import com.google.common.util.concurrent.ListenableFuture;
import com.homecredit.loan.utils.FastClickHelper;
import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Locale;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

public class CameraXActivity extends AppCompatActivity {
    private ImageCapture imageCapture;
    private CameraControl mCameraControl;
    private CameraInfo mCameraInfo;
    private boolean isInfer = true;
    private int flashMode = ImageCapture.FLASH_MODE_OFF;
    private CameraSelector cameraSelector = CameraSelector.DEFAULT_BACK_CAMERA;
    private ExecutorService cameraExecutor;

    private final String TAG = "CameraXActivity";
    private final int REQUEST_CODE_PERMISSIONS = 10;
//    private String[] REQUIRED_PERMISSIONS = {Manifest.permission.CAMERA, Manifest.permission.WRITE_EXTERNAL_STORAGE};
    private String[] REQUIRED_PERMISSIONS = {Manifest.permission.CAMERA};
    private PreviewView viewFinder;
    private ImageButton camera_switch_button;
    private ImageButton camera_capture_button;

    private Context context;
    private File outputDirectory;
    private final String FILENAME_FORMAT = "yyyy-MM-dd-HH-mm-ss-SSS";
    private CamaraParcelable mCameraParam;


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        int flag = WindowManager.LayoutParams.FLAG_FULLSCREEN;
        Window window = this.getWindow();
        window.setFlags(flag, flag);
        setContentView(R.layout.activity_camerax);
        Intent intent = getIntent();
        if (intent.getParcelableExtra(CamaraParcelable.CamaraConstante.CAMERA_PARAM_KEY) != null) {
            mCameraParam = (CamaraParcelable) intent.getParcelableExtra(CamaraParcelable.CamaraConstante.CAMERA_PARAM_KEY);
        }

        int type = intent.getIntExtra(CameraUtils.CameraType,0);
        if (type == CameraSelector.LENS_FACING_FRONT) {
            cameraSelector = CameraSelector.DEFAULT_FRONT_CAMERA;
        } else {
            cameraSelector = CameraSelector.DEFAULT_BACK_CAMERA;
        }

        initView();
        outputDirectory = getOutputDirectory();
        context = this;
        if (allPermissionsGranted()) {
            startCamera();
        } else {
            ActivityCompat.requestPermissions(this, REQUIRED_PERMISSIONS, REQUEST_CODE_PERMISSIONS);
        }
        camera_capture_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(!FastClickHelper.isOnDoubleClick()){
                    takePhoto();
                }
            }
        });
        cameraExecutor = Executors.newSingleThreadExecutor();
        camera_switch_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(!FastClickHelper.isOnDoubleClick()){
                    if (CameraSelector.DEFAULT_FRONT_CAMERA == cameraSelector) {
                        cameraSelector = CameraSelector.DEFAULT_BACK_CAMERA;
                    } else {
                        cameraSelector = CameraSelector.DEFAULT_FRONT_CAMERA;
                    }
                    startCamera();
                }
            }
        });


    }


    public File getOutputDirectory() {
        File file = new File(getExternalCacheDir(), getString(R.string.app_name));
        if (!file.exists()) {
            file.mkdir();
        }
        return file;
    }

    private void takePhoto() {
        ImageCapture tImageCapture = imageCapture;
        if (tImageCapture == null) {
            return;
        }
        File photoFile = new File(outputDirectory, new SimpleDateFormat(FILENAME_FORMAT, Locale.US).format(System.currentTimeMillis()) + ".jpg");
        ImageCapture.OutputFileOptions outputOptions = new ImageCapture.OutputFileOptions.Builder(photoFile).build();


        imageCapture.takePicture(outputOptions, ContextCompat.getMainExecutor(this), new ImageCapture.OnImageSavedCallback() {

            @Override
            public void onImageSaved(@NonNull ImageCapture.OutputFileResults outputFileResults) {
                Intent intent = new Intent();
                intent.putExtra(CamaraParcelable.CamaraConstante.PICTURE_PATH_KEY, photoFile.getAbsolutePath());
                setResult(RESULT_OK, intent);
                finish();
            }

            @Override
            public void onError(@NonNull ImageCaptureException exception) {

            }
        });

    }

    public boolean allPermissionsGranted() {
        for (String permission : REQUIRED_PERMISSIONS
        ) {

            if (!(ContextCompat.checkSelfPermission(getBaseContext(), permission) == PackageManager.PERMISSION_GRANTED)) {
                return false;
            }
        }
        return true;
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, @NonNull String[] permissions, @NonNull int[] grantResults) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        if (requestCode == REQUEST_CODE_PERMISSIONS) {
            if (allPermissionsGranted()) {
                startCamera();
            } else {
//                Toast.makeText(this, "，！", Toast.LENGTH_SHORT).show();
                finish();
            }
        }
    }

    @SuppressLint("UnsafeOptInUsageError")
    private void startCamera() {

        ListenableFuture<ProcessCameraProvider> cameraProviderFuture = ProcessCameraProvider.getInstance(this);
        cameraProviderFuture.addListener(new Runnable() {
            @Override
            public void run() {
                try {
                    ProcessCameraProvider cameraProvider = cameraProviderFuture.get();
                    int rotation = getWindowManager().getDefaultDisplay().getRotation();
                    Preview preview = new Preview.Builder().build();
                    preview.setSurfaceProvider(viewFinder.getSurfaceProvider());

                    imageCapture = new ImageCapture
                            .Builder()
                            .setFlashMode(flashMode)
                            .setCaptureMode(ImageCapture.CAPTURE_MODE_MAXIMIZE_QUALITY).build();


                    OrientationEventListener orientationEventListener = new OrientationEventListener(context) {
                        @Override
                        public void onOrientationChanged(int orientation) {
                            int rotation;

                            // Monitors orientation values to determine the target rotation value
                            if (orientation >= 45 && orientation < 135) {
                                rotation = Surface.ROTATION_270;
                            } else if (orientation >= 135 && orientation < 225) {
                                rotation = Surface.ROTATION_180;
                            } else if (orientation >= 225 && orientation < 315) {
                                rotation = Surface.ROTATION_90;
                            } else {
                                rotation = Surface.ROTATION_0;
                            }

                            imageCapture.setTargetRotation(rotation);
                        }
                    };

                    orientationEventListener.enable();
                    ImageAnalysis imageAnalysis = new ImageAnalysis.Builder().setTargetAspectRatio(AspectRatio.RATIO_4_3)
                            .setBackpressureStrategy(ImageAnalysis.STRATEGY_KEEP_ONLY_LATEST)
                            .build();
                    imageAnalysis.setAnalyzer(ContextCompat.getMainExecutor(context), new ImageAnalysis.Analyzer() {
                        @Override
                        public void analyze(@NonNull ImageProxy image) {
                            if (isInfer) {

                            }
                        }
                    });
                    try {
                        cameraProvider.unbindAll();
                        ViewPort viewPort = viewFinder.getViewPort();
                        UseCaseGroup useCaseGroup = new UseCaseGroup.Builder()
                                .addUseCase(preview)
                                .addUseCase(imageAnalysis)
                                .addUseCase(imageCapture)
                                .setViewPort(viewPort)
                                .build();
                        Camera camera = cameraProvider.bindToLifecycle(CameraXActivity.this, cameraSelector, useCaseGroup);
                        mCameraControl = camera.getCameraControl();
                        mCameraInfo = camera.getCameraInfo();

                        initCameraListener();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                } catch (ExecutionException e) {
                    e.printStackTrace();
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        }, ContextCompat.getMainExecutor(this));
    }

    private void initCameraListener() {
        LiveData<ZoomState> zoomState = mCameraInfo.getZoomState();
        CameraPreview cameraXPreviewViewTouchListener = new CameraPreview(this);
        cameraXPreviewViewTouchListener.setmCustomTouchListener(new CameraPreview.CustomTouchListener() {
            @Override
            public void zoom(Float delta) {
                ZoomState value = zoomState.getValue();
                float currentZoomRatio = value.getZoomRatio();
                mCameraControl.setZoomRatio(currentZoomRatio * delta);
            }

            @Override
            public void click(Float x, Float y) {
                MeteringPointFactory factory = viewFinder.getMeteringPointFactory();
                MeteringPoint point = factory.createPoint(x, y);
                FocusMeteringAction action = new FocusMeteringAction.Builder(point, FocusMeteringAction.FLAG_AF)
                        .setAutoCancelDuration(3, TimeUnit.SECONDS).build();
                ListenableFuture<FocusMeteringResult> future = mCameraControl.startFocusAndMetering(action);
                future.addListener(new Runnable() {
                    @Override
                    public void run() {
                        try {
                            final FocusMeteringResult result = future.get();
                            if (result.isFocusSuccessful()) {
                            } else {
                            }

                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }, ContextCompat.getMainExecutor(context));
            }
            @Override
            public void doubleClick(Float x, Float y) {
                float currentZoomRatio = zoomState.getValue().getZoomRatio();
                if (currentZoomRatio > zoomState.getValue().getMinZoomRatio()) {
                    mCameraControl.setLinearZoom(0f);
                } else {
                    mCameraControl.setLinearZoom(0.5f);
                }
            }
            @Override
            public void longPress(Float x, Float y) {
            }
        });
        viewFinder.setOnTouchListener(cameraXPreviewViewTouchListener);
    }
    @Override
    protected void onDestroy() {
        super.onDestroy();
        cameraExecutor.shutdown();
    }
    private void initView() {
        viewFinder = (PreviewView) findViewById(R.id.preview);
        camera_switch_button = (ImageButton) findViewById(R.id.ib_switch);
        camera_capture_button = (ImageButton) findViewById(R.id.ib_capture);
    }
}
