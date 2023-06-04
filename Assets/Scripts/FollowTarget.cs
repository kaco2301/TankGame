using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FollowTarget : MonoBehaviour
{
    [Header("카메라 위치, 각도, FOV--------------")]
    [SerializeField] Vector3 position = new Vector3(0, 3.6f, -7.8f); // 카메라 초기 위치
    [SerializeField] Vector3 rotation = new Vector3(14, 0, 0); // 카메라의 초기 회전각
    [SerializeField] [Range(10, 100)] float fov = 30f; // 카메라의 Field of View

    [Header("카메라 이동 및 회전 속도 --------------")]
    [SerializeField] float moveSpeed = 10f; // 카메라 이동 속도
    [SerializeField] float turnSpeed = 10f; // 카메라 회전 속도

    Transform target; // 추적대상
    Transform cam; // 카메라
    Transform pivot; // 카메라 이동 및 회전 축
    Transform pivotRot;
                     // Start is called before the first frame update
    void Start()
    {
        target = GameObject.Find("Player").transform; // Target 설정 (카메라가 추적할 목표를 설정)
        InitCamera();
    }

    void InitCamera()
    {
        // 카메라 설정
        cam = Camera.main.transform; // 메인카메라 정보를 읽음
        cam.GetComponent<Camera>().fieldOfView = fov;
        // 피벗 만들기



        pivot = new GameObject("Pivot").transform; // pivot라는 빈 오브젝트를 생성
        pivot.position = target.position;
        // 카메라를 피벗의 차일드로 설정

        pivotRot = new GameObject("PivotRot").transform;
        pivotRot.position = target.position;
        pivotRot.parent = pivot;


        //cam.parent = pivot;

        cam.parent = pivotRot;
        cam.localPosition = position;
        // cam.localEulerAngles = rotation;
        cam.localRotation = Quaternion.Euler(rotation);

    }

    private void FixedUpdate()
    {
        Vector3 pos = target.position;
        Quaternion rot = target.rotation;
        pivot.position = Vector3.Lerp(pivot.position, pos, moveSpeed * Time.deltaTime);
        pivot.rotation = Quaternion.Lerp(pivot.rotation, rot, turnSpeed * Time.deltaTime);


    }

    // Update is called once per frame
    void Update()
    {
        float zoom = Input.GetAxis("Mouse ScrollWheel") * 20;
        fov = Mathf.Clamp(fov - zoom, 10, 100);
        cam.GetComponent<Camera>().fieldOfView = fov;

        if (!Input.GetMouseButton(1)) return;

        float x = Input.GetAxis("Mouse Y") * 2;
        float y = Input.GetAxis("Mouse X") * 2;

        Vector3 ang = pivotRot.localEulerAngles + new Vector3(x, y, 0);
        if (ang.x > 180)
        {
            ang.x -= 360;
        }

        ang.x = Mathf.Clamp(ang.x, -24, 80);

        
        pivotRot.localEulerAngles = ang;
        //pivotRot.localRotation = Quaternion.Euler(ang);
    }
}
